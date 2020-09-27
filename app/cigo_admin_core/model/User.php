<?php
declare (strict_types=1);

namespace app\cigo_admin_core\model;

use Qiniu\Auth;
use think\facade\Config;
use think\Model;

/**
 * 用户模型
 * Class User
 * @package app\cigo_admin_core\model
 */
class User extends Model
{
    protected $table = 'cg_user';

    const  ROLE_FLAGS_COMMON_USER = 1;
    const  ROLE_FLAGS_COMMON_ADMIN = 2;
    const  ROLE_FLAGS_MAIN_ADMIN = 4;

    public function getAuthGroupAttr($value, $data)
    {
        return json_decode($data['auth_group'], true);
    }

    public function getImgInfoAttr($value, $data)
    {
        if (empty($data['img'])) {
            return null;
        }

        $imgInfo = Files::where('id', $data['img'])->findOrEmpty();
        if ($imgInfo->isEmpty()) {
            return null;
        }

        //解析平台
        switch ($imgInfo['platform']) {
            case 'qiniu'://七牛云
                {
                    // 生成访问防盗链链接
                    $qiniuConfig = Config::get('cigo.qiniu_cloud');
                    $auth = new Auth($qiniuConfig['AccessKey'], $qiniuConfig['SecretKey']);
                    $baseUrl = $qiniuConfig['bucketList'][$imgInfo['platform_bucket']]['cdn_host'] . '/' . $imgInfo['platform_key'];
                    if (stripos($imgInfo['platform_bucket'], '_open') !== false) {
                        // 私有空间中的防盗链外链
                        $baseUrl .= '?e=' . (time() + $qiniuConfig['bucketList'][$imgInfo['platform_bucket']]['timeout']);
                    }
                    $imgInfo['signed_url'] = $auth->privateDownloadUrl($baseUrl);
                }
                break;
            case 'tencent'://腾讯云
            case 'aliyun'://阿里云
            case 'local'://本地服务器
            default:
                break;
        }

        return $imgInfo;
    }
}
