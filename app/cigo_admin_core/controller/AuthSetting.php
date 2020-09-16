<?php

namespace app\cigo_admin_core\controller;

use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\library\traites\ApiCommon;
use app\cigo_admin_core\model\UserMgAuthRule;
use app\cigo_admin_core\validate\AddAuth;
use app\cigo_admin_core\validate\EditAuth;
use app\cigo_admin_core\validate\StatusAuth;

/**
 * Trait AuthSetting
 * @package app\cigo_admin_core\controller
 */
trait AuthSetting
{
    use ApiCommon;

    /**
     * 添加权限节点
     */
    protected function addAuthRule()
    {
        (new AddAuth())->runCheck();

        //添加节点
        UserMgAuthRule::create($this->args);

        return $this->makeApiReturn('添加成功');
    }

    /**
     * 修改权限节点
     */
    protected function editAuthRule()
    {
        (new EditAuth())->runCheck();

        //检查节点是否存在
        $node = UserMgAuthRule::where('id', $this->args['id'])->findOrEmpty();
        if($node->isEmpty()){
            return $this->makeApiReturn('节点不存在', ['id'=>$this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
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
        (new StatusAuth())->runCheck();

        //检查节点是否存在
        $node = UserMgAuthRule::where('id', $this->args['id'])->findOrEmpty();
        if($node->isEmpty() || $node->status == -1){
            return $this->makeApiReturn('节点不存在', ['id'=>$this->args['id']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        if($node->status == $this->args['status']){
            return $this->makeApiReturn('无需重复操作', ['id'=>$this->args['id'], 'status'=>$this->args['status']], ErrorCode::ClientError_ArgsWrong, HttpReponseCode::ClientError_BadRequest);
        }
        //修改节点
        UserMgAuthRule::update([
            'id'=>$this->args['id'],
            'status'=>$this->args['status'],
        ]);

        $tips = '';
        switch ($this->args['status']){
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
     * 获取权限节点级联列表
     */
    protected function getAuthRuleTreeList(){

    }

    /**
     * 添加权限分组
     */
    protected function addAuthGroup()
    {

    }

    /**
     * 修改权限分组
     */
    protected function editAuthGroup()
    {

    }

    /**
     * 配置权限分组权限
     */
    protected function configAuthGroupRule()
    {

    }

    /**
     * 获取权限分组列表
     */
    protected function getAuthGroupList()
    {

    }
}
