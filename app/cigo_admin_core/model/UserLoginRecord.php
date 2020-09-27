<?php
declare (strict_types=1);

namespace app\cigo_admin_core\model;

use app\cigo_admin_core\library\utils\ClientTye;
use think\facade\Request;
use think\Model;

/**
 * 用户登录记录
 * Class UserLoginRecord
 * @package app\cigo_admin_core\model
 */
class UserLoginRecord extends Model
{
    protected $table = 'cg_user_login_record';

    public static function recordSuccess($userId, $args)
    {
        UserLoginRecord::create([
            'user_id' => $userId,
            'user_agent' => strtolower(Request::header('USER_AGENT')),
            'client_type' => ClientTye::getClientType(),
            'if_success' => 1,
            'note' => '登录成功',
            'params' => json_encode($args),
            'create_time' => time()
        ]);
    }
}
