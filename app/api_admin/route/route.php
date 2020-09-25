<?php

use think\facade\Route;

// 根路由
Route::get('/', '/Index/index');

/**
 * v1 版本路由
 */

/*************************************数据改动类路由，进行分组便于做统一限制*************************************************/
Route::group('/:version/add/', function (){
    Route::post("User", "user/addUser");//添加权限节点
    Route::post("Manager", "manager/addManager");//添加权限节点
    Route::post("Rule", "auth/addRule");//添加权限节点
    Route::post("Group", "auth/addGroup");//添加权限分组
})->prefix(':version.')->middleware(\app\middleware\DemoShow::class);
Route::group('/:version/edit/', function (){
    Route::post("User", "user/editUser");//修改权限节点
    Route::post("Manager", "manager/editManager");//修改权限节点
    Route::post("Rule", "auth/editRule");//修改权限节点
    Route::post("Group", "auth/editGroup");//修改权限分组
})->prefix(':version.')->middleware(\app\middleware\DemoShow::class);
Route::group('/:version/status/', function (){
    Route::post("User", "user/statusUser");//设置权限节点状态
    Route::post("User", "user/statusUser");//设置权限节点状态
    Route::post("Manager", "manager/statusManager");//设置权限节点状态
    Route::post("Rule", "auth/statusRule");//设置权限节点状态
    Route::post("Group", "auth/statusGroup");//设置权限分组状态
})->prefix(':version.')->middleware(\app\middleware\DemoShow::class);
/********************************* 获取数据列表 *************************************************************************/
Route::post("/:version/userList", ":version.user/getUserList");//获取用户列表
Route::post("/:version/managerList", ":version.manager/getManagerList");//获取管理员列表
Route::post("/:version/groupList", ":version.auth/getGroupList");//获取权限分组列表
Route::get("/:version/menu/tree", ":version.menu/index");
Route::get("/:version/menu/both", ":version.menu/both");
Route::get("/:version/menu/base", ":version.menu/base");

/**********************************************************************************************************************/

Route::post(":version/login", ":version.manager/login"); //登录

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
