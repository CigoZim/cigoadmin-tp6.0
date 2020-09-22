<?php

use think\facade\Route;

// 根路由
Route::get('/', '/Index/index');

/**
 * 通用路由
 */

/**********************************************************************************************************************/

/**
 * v1 版本路由
 */

/**********************************************************************************************************************/

// 用户相关
Route::post("/:version/addUser", ":version.user/addUser");//添加权限节点
Route::post("/:version/editUser", ":version.user/editUser");//修改权限节点
Route::post("/:version/statusUser", ":version.user/statusUser");//设置权限节点状态
Route::post("/:version/userList", ":version.user/getUserList");//获取权限节点列表
// 管理员相关
Route::post(":version/login", ":version.manager/login");
Route::post("/:version/addManager", ":version.manager/addManager");//添加权限节点
Route::post("/:version/editManager", ":version.manager/editManager");//修改权限节点
Route::post("/:version/statusManager", ":version.manager/statusManager");//设置权限节点状态
Route::post("/:version/managerList", ":version.manager/getManagerList");//获取权限节点列表
// 权限管理相关
Route::post("/:version/addRule", ":version.auth/addRule");//添加权限节点
Route::post("/:version/editRule", ":version.auth/editRule");//修改权限节点
Route::post("/:version/statusRule", ":version.auth/statusRule");//设置权限节点状态
Route::post("/:version/addGroup", ":version.auth/addGroup");//添加权限分组
Route::post("/:version/editGroup", ":version.auth/editGroup");//修改权限分组
Route::post("/:version/statusGroup", ":version.auth/statusGroup");//设置权限分组状态
Route::post("/:version/groupList", ":version.auth/getGroupList");//获取权限分组列表
// 系统菜单
Route::get("/:version/menu/tree", ":version.menu/index");//
Route::get("/:version/menu/both", ":version.menu/both");//
Route::get("/:version/menu/base", ":version.menu/base");
// 文件上传
Route::post("/:version/file", ":version.file/upload");
Route::post("/:version/qiniu/token", ":version.qiniu/token");
Route::post("/:version/qiniu/notify", ":version.notify/qiniu");

/**********************************************************************************************************************/

//默认路由
Route::rule(
    "/:version",
    ":version.Index/index",
    'GET|POST'
);
