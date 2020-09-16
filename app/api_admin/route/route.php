<?php

use think\facade\Route;

// 根路由
Route::get('/', '/Index/index');

/**
 * 通用路由
 */

// 密码登录
Route::post(":version/login", ":version.user/login");


/**********************************************************************************************************************/

/**
 * v1 版本路由
 */

/**********************************************************************************************************************/
// 权限管理相关
Route::post("/:version/addRule", ":version.auth/addRule");//添加权限节点
Route::post("/:version/editRule", ":version.auth/editRule");//修改权限节点
Route::post("/:version/statusRule", ":version.auth/statusRule");//设置权限节点状态
Route::get("/:version/ruleList", ":version.auth/getRuleList");//获取权限节点列表
Route::post("/:version/addGroup", ":version.auth/addGroup");//添加权限分组
Route::post("/:version/editGroup", ":version.auth/editGroup");//修改权限分组
Route::post("/:version/statusGroup", ":version.auth/statusGroup");//设置权限分组状态
Route::post("/:version/configGroupRule", ":version.auth/configGroupRule");//配置权限分组权限
Route::post("/:version/groupList", ":version.auth/getGroupList");//获取权限分组列表
// 系统菜单
Route::get("/:version/menu/tree", ":version.menu/index");//
Route::get("/:version/menu/both", ":version.menu/both");//
Route::get("/:version/menu/base", ":version.menu/base");
// 文件上传
Route::post("/:version/file", ":version.file/upload");
Route::post("/:version/qiniu/token", ":version.qiniu/token");
Route::post("/:version/qiniu/notify", ":version.notify/qiniu");
//默认路由
Route::rule(
    "/:version",
    ":version.Index/index",
    'GET|POST'
);
