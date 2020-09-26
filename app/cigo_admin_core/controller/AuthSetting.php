<?php

namespace app\cigo_admin_core\controller;

use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\library\traites\ApiCommon;
use app\cigo_admin_core\library\traites\Tree;
use app\cigo_admin_core\model\UserMgAuthGroup;
use app\cigo_admin_core\model\UserMgAuthRule;
use app\cigo_admin_core\validate\AddAuthGroup;
use app\cigo_admin_core\validate\AddAuthRule;
use app\cigo_admin_core\validate\EditAuthGroup;
use app\cigo_admin_core\validate\EditAuthRule;
use app\cigo_admin_core\validate\Status;

/**
 * Trait AuthSetting
 * @package app\cigo_admin_core\controller
 */
trait AuthSetting
{
    use Tree;
    use ApiCommon;

    /**
     * 添加权限节点
     */
    protected function addAuthRule()
    {
        (new AddAuthRule())->runCheck();

        //添加节点
        UserMgAuthRule::create($this->args);

        return $this->makeApiReturn('添加成功');
    }

    /**
     * 修改权限节点
     */
    protected function editAuthRule()
    {
        (new EditAuthRule())->runCheck();

        //检查节点是否存在
        $node = UserMgAuthRule::where('id', $this->args['id'])->findOrEmpty();
        if ($node->isEmpty()) {
            return $this->makeApiReturn('节点不存在', ['id' => $this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //修改节点
        UserMgAuthRule::update($this->args);

        return $this->makeApiReturn('修改成功');
    }

    /**
     * 设置权限节点状态
     */
    protected function setAuthRuleStatus()
    {
        (new Status())->runCheck();

        //检查节点是否存在
        $node = UserMgAuthRule::where('id', $this->args['id'])->findOrEmpty();
        if ($node->isEmpty() || $node->status == -1) {
            return $this->makeApiReturn('节点不存在', ['id' => $this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        if ($node->status == $this->args['status']) {
            return $this->makeApiReturn('无需重复操作', ['id' => $this->args['id'], 'status' => $this->args['status']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //状态
        UserMgAuthRule::update([
            'id' => $this->args['id'],
            'status' => $this->args['status'],
        ]);
        return $this->makeApiReturn($this->makeStatusTips());
    }

    /**
     * 添加权限分组
     */
    protected function addAuthGroup()
    {
        (new AddAuthGroup())->runCheck();

        //添加节点
        $group = UserMgAuthGroup::create([
            'module' => empty($this->args['module']) ? 'admin' : $this->args['module'],
            'title' => $this->args['title'],
            'pid' => $this->args['pid'],
            'path' => $this->args['path'],
            'rules' => json_encode($this->args['rules']),
            'summary' => $this->args['summary'],
        ]);
        $group = UserMgAuthGroup::where('id', $group->id)->find();
        return $this->makeApiReturn('添加成功', $group);
    }

    /**
     * 修改权限分组
     */
    protected function editAuthGroup()
    {
        (new EditAuthGroup())->runCheck();

        //检查节点是否存在
        $group = UserMgAuthGroup::where('id', $this->args['id'])->findOrEmpty();
        if ($group->isEmpty()) {
            return $this->makeApiReturn('角色不存在', ['id' => $this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //修改角色
        $group = UserMgAuthGroup::update([
            'id' => $this->args['id'],
            'title' => empty($this->args['title']) ? $group->title : $this->args['title'],
            'pid' => empty($this->args['pid']) ? $group->pid : $this->args['pid'],
            'path' => empty($this->args['path']) ? $group->path : $this->args['path'],
            'rules' => empty($this->args['rules']) ? $group->rules : json_encode($this->args['rules']),
            'summary' => empty($this->args['summary']) ? $group->summary : $this->args['summary'],
        ]);

        return $this->makeApiReturn('修改成功', $group);
    }

    /**
     * 设置权限分组状态
     */
    protected function setAuthGroupStatus()
    {
        (new Status())->runCheck();

        //检查角色是否存在
        $group = UserMgAuthGroup::where('id', $this->args['id'])->findOrEmpty();
        if ($group->isEmpty() || $group->status == -1) {
            return $this->makeApiReturn('角色不存在', ['id' => $this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        if ($group->status == $this->args['status']) {
            return $this->makeApiReturn('无需重复操作', ['id' => $this->args['id'], 'status' => $this->args['status']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //更新状态
        UserMgAuthGroup::update([
            'id' => $this->args['id'],
            'status' => $this->args['status'],
        ]);
        return $this->makeApiReturn($this->makeStatusTips());
    }

    /**
     * 获取权限分组列表
     */
    protected function getAuthGroupList()
    {
        isset($this->args['status'])
            ? $map[] = ['status', 'in', $this->args['status']]
            : $map[] = ['status', '<>', -1];
        $map[] = ['module', '=', empty($this->args['module']) ? 'admin' : $this->args['module']];

        $model = UserMgAuthGroup::where($map);
        $dataList = $model->order('pid asc, sort desc, id asc')->select();
        $treeList = [];
        if ($dataList) {
            $this->convertToTree($dataList, $treeList, 0, 'pid', false);
        }
        return $this->makeApiReturn('获取成功', $treeList);
    }
}
