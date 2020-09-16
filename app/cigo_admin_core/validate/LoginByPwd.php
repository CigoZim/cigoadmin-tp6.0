<?php
declare (strict_types = 1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class LoginByPwd extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */	
	protected $rule = [
	    'username'=>'require',
        'password'=>'require',
        'module'=>'require',
    ];
    
    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */	
    protected $message = [
        'username.require'=>'请填写用户名',
        'password.require'=>'请输入密码',
        'module.require'=>'未指定登录模块',
    ];
}
