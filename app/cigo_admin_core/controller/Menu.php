<?php

namespace app\cigo_admin_core\controller;

use app\cigo_admin_core\library\traites\Tree;
use app\cigo_admin_core\model\UserMgAuthRule;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

/**
 * Trait Manager
 * @package app\cigo_admin_core\controller
 */
trait Menu
{
    use Tree;

    /**
     * 管理后台左侧菜单--分层级数据
     * @return mixed
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function menuTree()
    {
        $treeList = (new UserMgAuthRule())->menuTree();
        return $this->makeApiReturn('获取成功', $treeList);
    }

    /**
     * 基础菜单数据，用于前端检测使用
     * @return mixed
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function menuBase()
    {
        $baseList = (new UserMgAuthRule())->menuBase();
        return $this->makeApiReturn('获取成功', $baseList);
    }

    /**
     * 获取层级和基础菜单数据
     * @return mixed
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function menuBoth()
    {
        $treeList = (new UserMgAuthRule())->menuTree();
        $baseList = (new UserMgAuthRule())->menuBase();
        return $this->makeApiReturn('获取成功', [
            'treeList' => $treeList,
            'baseList' => $baseList
        ]);
    }
}

