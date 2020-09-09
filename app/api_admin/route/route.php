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
// 系统菜单
Route::get("/:version/menu/tree", ":version.menu/index");
Route::get("/:version/menu/both", ":version.menu/both");
Route::get("/:version/menu/base", ":version.menu/base");
// 文件上传
Route::post("/:version/file", ":version.file/upload");
// 获取七牛云上传凭证
Route::post("/:version/qiniu/token", ":version.qiniu/token");
// 七牛云上传回调通知
Route::post("/:version/qiniu/notify", ":version.notify/qiniu");
//默认路由
Route::rule(
    "/:version",
    ":version.Index/index",
    'GET|POST'
);
