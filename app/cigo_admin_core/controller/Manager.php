<?php

namespace app\cigo_admin_core\controller;

use app\cigo_admin_core\library\Encrypt;
use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\library\traites\ApiCommon;
use app\cigo_admin_core\model\User;
use app\cigo_admin_core\model\UserLoginRecord;
use app\cigo_admin_core\validate\AddManager;
use app\cigo_admin_core\validate\EditManager;
use app\cigo_admin_core\validate\ListPage;
use app\cigo_admin_core\validate\LoginByPwd;
use app\cigo_admin_core\validate\Status;
use Think\Exception;
use think\facade\Cache;

/**
 * Trait Manager
 * @package app\cigo_admin_core\controller
 */
trait Manager
{
    use ApiCommon;

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
        $admin = User::where([
            ['username|phone', '=', $this->args['username']],
            ['module', '=', $this->args['module']],
        ])->append(['img_info'])->findOrEmpty();
        if ($admin->isEmpty()) {
            return $this->makeApiReturn('用户不存在', [], ErrorCode::ClientError_AuthError, HttpReponseCode::ClientError_Forbidden);
        }

        //检查用户类型
        if (
            ($admin->role_flag & User::ROLE_FLAGS_MAIN_ADMIN) === 0 &&
            ($admin->role_flag & User::ROLE_FLAGS_COMMON_ADMIN) === 0
        ) {
            return $this->makeApiReturn('非管理员用户', [], ErrorCode::ClientError_AuthError, HttpReponseCode::ClientError_Forbidden);
        }

        //检测密码
        if ($admin->password !== Encrypt::encrypt($this->args['password'])) {
            return $this->makeApiReturn('密码错误', [
//                'password'=>Encrypt::encrypt('123456')
            ], ErrorCode::ClientError_AuthError, HttpReponseCode::ClientError_Forbidden);
        }

        //检查状态
        if ($admin->status !== 1) {
            return $this->makeApiReturn('用户被禁止', [], ErrorCode::ClientError_AuthError, HttpReponseCode::ClientError_Forbidden);
        }

        //生成用户token
        $token = Encrypt::makeToken();
        $admin->token = $token;
        $admin->token_create_time = time();
        $admin->last_log_time = time();
        $admin->save();
        Cache::set('user_token_' . $this->moduleName . '_' . $token, $admin->id, 7 * 24 * 60 * 60);

        //记录登录信息
        $this->args['password'] = isset($this->args['password']) ? Encrypt::encrypt($this->args['password']) : '';//避免客户密码泄露
        UserLoginRecord::recordSuccess($admin->id, $this->args);

        return $this->makeApiReturn('登录成功', $admin->hidden(['password']), ErrorCode::OK, HttpReponseCode::Success_OK);
    }

    /**
     * 添加管理员
     */
    protected function add()
    {
        (new AddManager())->runCheck();

        //添加管理员
        empty($this->args['module']) ? $this->args['module'] = 'admin' : false;
        isset($this->args['password']) ? $this->args['password'] = Encrypt::encrypt($this->args['password']) : false;
        isset($this->args['auth_group'])
            ? $this->args['auth_group'] = empty($this->args['auth_group']) ? '[]' : json_encode($this->args['auth_group'], JSON_UNESCAPED_UNICODE)
            : false;
        $this->args['create_time'] = time();

        $manager = User::create($this->args);
        $manager = User::where('id', $manager->id)->append(['img_info'])->find();
        return $this->makeApiReturn('添加成功', $manager->hidden(['token', 'token_create_time', 'password']));
    }

    /**
     * 修改管理员
     */
    protected function edit()
    {
        (new EditManager())->runCheck();

        //检查管理员是否存在
        $manager = User::where('id', $this->args['id'])->findOrEmpty();
        if ($manager->isEmpty()) {
            return $this->makeApiReturn('管理员不存在', ['id' => $this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //修改管理员
        if (isset($this->args['module']) && empty($this->args['module'])) {
            unset($this->args['module']);
        }
        isset($this->args['password']) ? $this->args['password'] = Encrypt::encrypt($this->args['password']) : false;
        isset($this->args['auth_group'])
            ? $this->args['auth_group'] = empty($this->args['auth_group']) ? '[]' : json_encode($this->args['auth_group'], JSON_UNESCAPED_UNICODE)
            : false;
        $this->args['update_time'] = time();
        $manager = User::update($this->args);
        $manager = User::where('id', $manager->id)->append(['img_info'])->find();
        return $this->makeApiReturn('修改成功', $manager->hidden(['token', 'token_create_time', 'password']));
    }

    /**
     * 设置管理员状态
     */
    protected function setStatus()
    {
        (new Status())->runCheck();

        //检查管理员是否存在
        $manager = User::where('id', $this->args['id'])->findOrEmpty();
        if ($manager->isEmpty() || $manager->status == -1) {
            return $this->makeApiReturn('管理员不存在', ['id' => $this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        if ($manager->status == $this->args['status']) {
            return $this->makeApiReturn('无需重复操作', ['id' => $this->args['id'], 'status' => $this->args['status']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //更新状态
        User::update([
            'id' => $this->args['id'],
            'status' => $this->args['status'],
        ]);
        return $this->makeApiReturn($this->makeStatusTips());
    }

    /**
     * 获取管理员列表
     */
    protected function getList()
    {
        (new ListPage())->runCheck();

        $map = [
            ['status', '<>', -1],
            ['role_flag', 'in', [User::ROLE_FLAGS_COMMON_ADMIN, User::ROLE_FLAGS_MAIN_ADMIN]],
            ['module', '=', empty($this->args['module']) ? 'admin' : $this->args['module']]
        ];

        $model = User::where($map)->hidden(['token', 'token_create_time', 'password']);
        if (!empty($this->args['page']) && !empty($this->args['pageSize'])) {
            $model->page($this->args['page'], $this->args['pageSize']);
        }
        $dataList = $model->order('id desc')->append(['img_info'])->select();
        return $this->makeApiReturn('获取成功', $dataList->isEmpty() ? [] : $dataList);
    }
}

