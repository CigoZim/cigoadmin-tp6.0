<?php
declare (strict_types=1);

namespace app\cigo_admin_core\model;

use app\cigo_admin_core\controller\UploadCloud;
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
    use UploadCloud;

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
        return $this->getFileInfo($data);
    }
}
