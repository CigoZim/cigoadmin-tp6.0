<?php
declare (strict_types = 1);

namespace app\index\controller;

use think\facade\View;

class Index
{
    public function index()
    {
//        return '您好！这是一个[index]示例应用';
        return View::fetch();
    }
}
