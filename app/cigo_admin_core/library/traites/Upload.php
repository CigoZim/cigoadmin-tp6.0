<?php

namespace app\cigo_admin_core\library\traites;

use app\cigo_admin_core\library\uploader\UploadMg;
use app\cigo_admin_core\validate\GetQiniuFile;
use app\cigo_admin_core\validate\MakeQiniuToken;
use Qiniu\Auth;
use think\facade\Config;
use think\facade\Validate;
use think\validate\ValidateRule;

/**
 * Trait Upload
 * @package app\cigo_admin_core\library\traites
 * @summary 负责后台管理中的文件上传操作
 */
trait Upload
{
    use ApiCommon;

    /**
     * 文件上传
     */
    public function upload()
    {
        //1. 实例化上传类，并创建文件上传实例
        $upMg = new UploadMg();
        $upMg->init()->makeFileUploader();

        //2. 执行上传操作
        $upMg->doUpload();
    }
    /******************************= 七牛云：开始 =**********************************/
    /**
     * 创建七牛云上传凭证
     */
    public function makeQiniuyunToken()
    {
        //检查参数
        (new MakeQiniuToken())->runCheck();

        $qiniuConfig = Config::get('cigo.qiniu_cloud');
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
            $qiniuConfig[$this->args['bucket']]['bucket'],
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
     * 前端上传后保存七牛云文件信息
     */
    public function saveQiniuyunFileToDb()
    {

    }

    /**
     * 获取七牛云文件地址
     */
    public function getQiniuyunFile()
    {
        // 检查参数
        (new GetQiniuFile())->runCheck();

        $qiniuConfig = Config::get('cigo.qiniu_cloud');
        $auth = new Auth($qiniuConfig['AccessKey'], $qiniuConfig['SecretKey']);
        $baseUrl = $qiniuConfig['host'] . '/' . $this->args['fileKey'];
        if ($this->args['bucket'] !== 'open') {
            // 私有空间中的防盗链外链
            $baseUrl .= '?e=' . (time() + $qiniuConfig[$this->args['bucket']]['timeout']);
        }
        // 对链接进行签名
        $signedUrl = $auth->privateDownloadUrl($baseUrl);
        return $this->makeApiReturn('获取成功', [
            'url' => $signedUrl
        ]);
    }

    /******************************= 七牛云：结束 =**********************************/
}