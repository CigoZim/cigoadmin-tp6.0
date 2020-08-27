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
// 文件上传
Route::post("/:version/file", ":version.file/upload");
//默认路由
Route::rule(
    "/:version",
    ":version.Index/index",
    'GET|POST'
);
