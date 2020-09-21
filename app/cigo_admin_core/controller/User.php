<?php

namespace app\cigo_admin_core\controller;

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
        $user = UserModel::create([
            'module' => empty($this->args['module']) ? 'client' : $this->args['module'],
            'role_flag' => UserModel::ROLE_FLAGS_COMMON_USER,
            'username' => $this->args['username'],
            'nickname' => empty($this->args['nickname']) ? '' : $this->args['nickname'],
            'realname' => $this->args['realname'],
            'sex' => $this->args['sex'],
            'phone' => $this->args['phone'],
            'hospital' => $this->args['hospital'],
            'department_id' => $this->args['department_id'],
            'professional_id' => $this->args['professional_id'],
            'create_time' => time()
        ]);
        $user = User::where('id', $user->id)->find();
        return $this->makeApiReturn('添加成功', $user);
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
        $user = UserModel::update([
            'username' => empty($this->args['username']) ? null : $this->args['username'],
            'nickname' => empty($this->args['nickname']) ? null : $this->args['nickname'],
            'realname' => empty($this->args['realname']) ? null : $this->args['realname'],
            'sex' => !isset($this->args['sex']) ? null : $this->args['sex'],
            'phone' => empty($this->args['phone']) ? null : $this->args['phone'],
            'hospital' => empty($this->args['hospital']) ? null : $this->args['hospital'],
            'department_id' => !isset($this->args['department_id']) ? null : $this->args['department_id'],
            'professional_id' => !isset($this->args['professional_id']) ? null : $this->args['professional_id'],
            'update_time' => time()
        ]);

        return $this->makeApiReturn('修改成功', $user);
    }

    /**
     * 设置用户状态
     */
    protected function setStatus()
    {
        (new Status())->runCheck();

        //检查用户是否存在
        $user = User::where('id', $this->args['id'])->findOrEmpty();
        if ($user->isEmpty() || $user->status == -1) {
            return $this->makeApiReturn('用户不存在', ['id' => $this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        if ($user->status == $this->args['status']) {
            return $this->makeApiReturn('无需重复操作', ['id' => $this->args['id'], 'status' => $this->args['status']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //更新状态
        User::update([
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
    protected function getUserList()
    {
        (new ListPage())->runCheck();

        $map = [
            ['status', '<>', -1],
            ['role_flag', '=', UserModel::ROLE_FLAGS_COMMON_USER],
            ['module', '=', empty($this->args['module']) ? $this->args['module'] : 'client']
        ];

        $model = User::where($map);
        if (!empty($this->args['page']) && !empty($this->args['pageSize'])) {
            $model->page($this->args['page'], $this->args['pageSize']);
        }
        $dataList = $model->order('id desc')->select();
        return $this->makeApiReturn('获取成功', $dataList->isEmpty() ? [] : $dataList);
    }
}

