<?php

namespace app\cigo_admin_core\controller;

use app\cigo_admin_core\library\Encrypt;
use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\model\User as UserModel;
use app\cigo_admin_core\validate\AddUser;
use app\cigo_admin_core\validate\EditUser;
use app\cigo_admin_core\validate\ListPage;
use app\cigo_admin_core\validate\Status;

/**
 * Trait Manager
 * @package app\cigo_admin_core\controller
 */
trait User
{
    /**
     * 添加用户
     */
    protected function add()
    {
        (new AddUser())->runCheck();

        //添加用户
        empty($this->args['module']) ? $this->args['module'] = 'client' : false;
        isset($this->args['password']) ? $this->args['password'] = Encrypt::encrypt($this->args['password']) : false;
        $this->args['role_flag'] = UserModel::ROLE_FLAGS_COMMON_USER;
        $this->args['create_time'] = time();
        $user = UserModel::create($this->args);
        $user = UserModel::where('id', $user->id)->append(['img_info'])->find();
        return $this->makeApiReturn('添加成功', $user->hidden(['token', 'token_create_time', 'password']));
    }


    /**
     * 修改用户
     */
    protected function edit()
    {
        (new EditUser())->runCheck();

        //检查用户是否存在
        $user = UserModel::where('id', $this->args['id'])->findOrEmpty();
        if ($user->isEmpty()) {
            return $this->makeApiReturn('用户不存在', ['id' => $this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //修改用户
        if (isset($this->args['module']) && empty($this->args['module'])) {
            unset($this->args['module']);
        }
        isset($this->args['password']) ? $this->args['password'] = Encrypt::encrypt($this->args['password']) : false;
        $this->args['update_time'] = time();
        $user = UserModel::update($this->args);
        $user = UserModel::where('id', $user->id)->append(['img_info'])->find();
        return $this->makeApiReturn('修改成功', $user->hidden(['token', 'token_create_time', 'password']));
    }

    /**
     * 设置用户状态
     */
    protected function setStatus()
    {
        (new Status())->runCheck();

        //检查用户是否存在
        $user = UserModel::where('id', $this->args['id'])->findOrEmpty();
        if ($user->isEmpty() || $user->status == -1) {
            return $this->makeApiReturn('用户不存在', ['id' => $this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        if ($user->status == $this->args['status']) {
            return $this->makeApiReturn('无需重复操作', ['id' => $this->args['id'], 'status' => $this->args['status']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //更新状态
        UserModel::update([
            'id' => $this->args['id'],
            'status' => $this->args['status'],
        ]);

        $tips = '';
        switch ($this->args['status']) {
            case 0:
                $tips = '禁用成功';
                break;
            case 1:
                $tips = '启用成功';
                break;
            case -1:
                $tips = '删除成功';
                break;
        }

        return $this->makeApiReturn($tips);
    }

    /**
     * 获取用户列表
     */
    protected function getList()
    {
        (new ListPage())->runCheck();

        $map = [
            ['status', '<>', -1],
            ['role_flag', '=', UserModel::ROLE_FLAGS_COMMON_USER],
            ['module', '=', empty($this->args['module']) ? 'client' : $this->args['module']]
        ];

        $model = UserModel::where($map)->hidden(['token', 'token_create_time', 'password']);
        if (!empty($this->args['page']) && !empty($this->args['pageSize'])) {
            $model->page($this->args['page'], $this->args['pageSize']);
        }
        $dataList = $model->order('id desc')->append(['img_info'])->select();
        return $this->makeApiReturn('获取成功', $dataList->isEmpty() ? [] : $dataList);
    }
}

