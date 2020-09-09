<?php

namespace app\cigo_admin_core\library\traites;

use app\cigo_admin_core\library\Encrypt;
use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\model\User as UserModel;
use app\cigo_admin_core\model\UserLoginRecord;
use app\cigo_admin_core\model\UserMgAuthRule;
use app\cigo_admin_core\validate\LoginByPwd;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use Think\Exception;
use think\facade\Cache;

/**
 * Trait Manager
 * @package app\cigo_admin_core\library\traites
 */
trait Manager
{
    use Tree;

    /**
     * 管理员登录操作
     * @return mixed
     * @throws Exception
     */
    protected function doLogin()
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

    /**
     * 管理后台左侧菜单--分层级数据
     * @return mixed
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function menuTree(){
        $treeList = (new UserMgAuthRule())->menuTree();
        return $this->makeApiReturn('获取成功', $treeList);
    }

    /**
     * 基础菜单数据，用于前端检测使用
     * @return mixed
     */
    protected function menuBase()
    {
        $baseList= (new UserMgAuthRule())->menuBase();
        return $this->makeApiReturn('获取成功', $baseList);
    }

    /**
     * 获取层级和基础菜单数据
     * @return mixed
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function menuBoth(){
        $treeList = (new UserMgAuthRule())->menuTree();
        $baseList= (new UserMgAuthRule())->menuBase();
        return $this->makeApiReturn('获取成功', [
            'treeList'=>$treeList,
            'baseList'=>$baseList
        ]);
    }
}

