<?php

namespace app\cigo_admin_core\library\traites;

use app\cigo_admin_core\library\Encrypt;
use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\model\User as UserModel;
use app\cigo_admin_core\model\UserLoginRecord;
use app\cigo_admin_core\validate\LoginByPwd;
use think\facade\Cache;

/**
 * Trait Manager
 * @package app\cigo_admin_core\library\traites
 */
trait Manager
{
    public function login()
    {
        (new LoginByPwd())->runCheck();

        //检查模块是否正确
        if ($this->args['module'] !== $this->moduleName) {
            return $this->makeApiReturn('非本模块操作', [], ErrorCode::ClientError_AuthError, HttpReponseCode::ClientError_Forbidden);
        }

        //检查用户是否存在
        $admin = UserModel::where([
            ['username|phone', '=', $this->args['username']],
            ['module', '=', $this->args['module']],
        ])->findOrEmpty();
        if ($admin->isEmpty()) {
            return $this->makeApiReturn('用户不存在', [], ErrorCode::ClientError_AuthError, HttpReponseCode::ClientError_Forbidden);
        }

        //检查用户类型
        if (
            ($admin->role_flag & UserModel::ROLE_FLAGS_MAIN_ADMIN) === 0 &&
            ($admin->role_flag & UserModel::ROLE_FLAGS_COMMON_ADMIN) === 0
        ) {
            return $this->makeApiReturn('非管理员用户', [], ErrorCode::ClientError_AuthError, HttpReponseCode::ClientError_Forbidden);
        }

        //检测密码
        if ($admin->password !== Encrypt::encrypt($this->args['password'])) {
            return $this->makeApiReturn('密码错误', [], ErrorCode::ClientError_AuthError, HttpReponseCode::ClientError_Forbidden);
        }

        //检查状态
        if ($admin->status !== 1) {
            return $this->makeApiReturn('用户被禁止', [], ErrorCode::ClientError_AuthError, HttpReponseCode::ClientError_Forbidden);
        }

        //生成用户token
        $token = Encrypt::makeToken();
        $admin->token = $token;
        $admin->token_create_time = time();
        $admin->save();
        Cache::set('user_token_' . $this->moduleName . '_' . $token, $admin->id, 7 * 24 * 60 * 60);

        //记录登录信息
        $this->args['password'] = isset($this->args['password']) ? Encrypt::encrypt($this->args['password']) : '';//避免客户密码泄露
        UserLoginRecord::recordSuccess($admin->id, $this->args);

        return $this->makeApiReturn('登录成功', [
            'id' => $admin->id,
            'token' => $admin->token,
            'username' => $admin->username,
            'phone' => $admin->phone,
            'nickname' => $admin->nickname,
            'real_name' => $admin->real_name,
            'email' => $admin->email,
            'role_flag' => $admin->role_flag,
        ], ErrorCode::OK, HttpReponseCode::Success_OK);
    }
}

