<?php

namespace app\cigo_admin_core\controller;

use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\library\traites\ApiCommon;
use app\cigo_admin_core\model\Files;
use app\cigo_admin_core\validate\MakeQiniuToken;
use Qiniu\Auth;
use think\facade\Config;
use think\facade\Log;
use think\Model;

/**
 * Trait UploadCloud
 * @package app\cigo_admin_core\controller
 */
trait UploadCloud
{
    use ApiCommon;

    /******************************= 七牛云：开始 =**********************************/
    /**
     * 创建七牛云上传凭证
     */
    private function makeQiniuyunToken()
    {
        //检查参数
        (new MakeQiniuToken())->runCheck();
        $qiniuConfig = Config::get('cigo.qiniu_cloud');
        if (!isset($qiniuConfig['bucketList'][$this->args['bucket']])) {
            return $this->makeApiReturn('存储空间不存在', [], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        $auth = new Auth($qiniuConfig['AccessKey'], $qiniuConfig['SecretKey']);
        $policy = $qiniuConfig['enableCallbackServer']
            ? [
                'callbackUrl' => $qiniuConfig['callbackUrl'],
                'callbackBodyType' => $qiniuConfig['callbackBodyType'],
                'callbackBody' => $qiniuConfig['callbackBody'],
            ]
            : [
                'returnBody' => $qiniuConfig['returnBody']
            ];
        $token = $auth->uploadToken(
            $this->args['bucket'],
            null,
            $qiniuConfig['tokenExpireTime'],
            $policy,
            true
        );

        return $this->makeApiReturn('获取成功', [
            'token' => $token,
            'upload_host' => $qiniuConfig['host']
        ]);
    }

    /**
     * 七牛云文件上传通知
     */
    private function qiniuNotify()
    {
        Log::record('------------------------------------');
        Log::record(json_encode($this->args), JSON_UNESCAPED_UNICODE);
        Log::record('------------------------------------');

        //开始对七牛回调进行鉴权
        $qiniuConfig = Config::get('cigo.qiniu_cloud');
        $auth = new Auth($qiniuConfig['AccessKey'], $qiniuConfig['SecretKey']);
        $authorization = $_SERVER['HTTP_AUTHORIZATION'];
        $callbackBody = file_get_contents('php://input');//获取回调的body信息
        $isQiniuCallback = $auth->verifyCallback($qiniuConfig['callbackBodyType'], $authorization, $qiniuConfig['callbackUrl'], $callbackBody);
        if (!$isQiniuCallback) {
            $this->args['isQiniuCallback'] = $isQiniuCallback;
            $this->args['authorization'] = $authorization;
            $this->args['callbackBody'] = $callbackBody;

            return $this->makeApiReturn('七牛回调鉴权失败', $this->args);
        }

        try {
            //保存文件信息到数据库
            $file = Files::where([
                ['platform', '=', 'qiniu'],
                ['platform_bucket', '=', $this->args['bucket']],
                ['platform_key', '=', $this->args['key']],
                ['name', '=', $this->args['fname']],
                ['hash', '=', $this->args['hash']],
            ])->findOrEmpty();
            if ($file->isEmpty()) {
                $ext = pathinfo($this->args['fname'], PATHINFO_EXTENSION);
                $type = in_array($ext, ['png', 'jpg', 'jpeg', 'bmp', 'gif'])
                    ? 'img'
                    : (in_array($ext, ['mp4', 'rmvb', 'mov'])
                        ? 'video'
                        : 'file'
                    );
                $file = Files::create([
                    'platform' => 'qiniu',
                    'platform_bucket' => $this->args['bucket'],
                    'platform_key' => $this->args['key'],
                    'type' => $type,
                    'name' => $this->args['fname'],
                    'prefix' => $this->args['fprefix'],
                    'ext' => $ext,
                    'name_saved' => $this->args['key'],
                    'mime' => $this->args['mimeType'],
                    'hash' => $this->args['hash'],
                    'size' => $this->args['fsize'],
                    'create_time' => time(),
                ]);
            }
            // 生成访问防盗链链接
            $baseUrl = $qiniuConfig['bucketList'][$this->args['bucket']]['cdn_host'] . '/' . $this->args['key'];
            if (stripos($this->args['bucket'], '_open') !== false) {
                // 私有空间中的防盗链外链
                $baseUrl .= '?e=' . (time() + $qiniuConfig['bucketList'][$this->args['bucket']]['timeout']);
            }
            $signedUrl = $auth->privateDownloadUrl($baseUrl);

            return $this->makeApiReturn('上传成功', [
                'id' => $file->id,
                'platform' => $file->platform,
                'platform_bucket' => $file->platform_bucket,
                'platform_key' => $file->platform_key,
                'name' => $file->name,
                'prefix' => $file->name,
                'ext' => $file->ext,
                'mime' => $file->mime,
                'hash' => $file->hash,
                'size' => $file->size,
                'create_time' => $file->create_time,
                'signed_url' => $signedUrl,
                'callbackBody' => $callbackBody
            ]);
        } catch (\Exception $exception) {
            return $this->makeApiReturn($exception->getMessage(), json_encode($exception), JSON_UNESCAPED_UNICODE);
        }
    }

    /******************************= 七牛云：结束 =*********************************/

    /**
     * @param $data
     * @param string $key
     * @return array|Model|null
     */
    private function getFileInfo($data, $key = 'img')
    {
        if (empty($data[$key])) {
            return null;
        }
        $info = Files::where('id', $data[$key])->findOrEmpty();
        if ($info->isEmpty()) {
            return null;
        }
        switch ($info['platform']) {
            case 'qiniu'://七牛云
                {
                    // 生成访问防盗链链接
                    $qiniuConfig = Config::get('cigo.qiniu_cloud');
                    $auth = new Auth($qiniuConfig['AccessKey'], $qiniuConfig['SecretKey']);
                    $baseUrl = $qiniuConfig['bucketList'][$info['platform_bucket']]['cdn_host'] . '/' . $info['platform_key'];
                    if (stripos($info['platform_bucket'], '_open') !== false) {
                        // 私有空间中的防盗链外链
                        $baseUrl .= '?e=' . (time() + $qiniuConfig['bucketList'][$info['platform_bucket']]['timeout']);
                    }
                    $info['signed_url'] = $auth->privateDownloadUrl($baseUrl);
                }
                break;
            case 'tencent'://腾讯云
            case 'aliyun'://阿里云
            case 'local'://本地服务器
            default:
                break;
        }

        return $info;
    }
}
