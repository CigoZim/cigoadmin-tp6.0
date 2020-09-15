<?php

namespace app\cigo_admin_core\controller;

use app\cigo_admin_core\library\traites\ApiCommon;
use app\cigo_admin_core\model\UserMgAuthRule;
use app\cigo_admin_core\validate\AddAuth;

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
