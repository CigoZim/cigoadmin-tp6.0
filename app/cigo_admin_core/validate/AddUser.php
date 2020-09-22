<?php
declare (strict_types=1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class AddUser extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'    =>    ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'username' => 'require',
        'sex' => 'require|in:0,1,2',
        'phone' => 'require|mobile',
        'email' => 'require|email',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */
    protected $message = [
        'username.require' => '请提供用户名',
        'sex.require' => '请设置性别',
        'sex.in' => '性别错误',
        'phone.require' => '请提供手机号',
        'phone.mobile' => '手机号格式错误',
        'email.require' => '请提供邮箱',
        'email.email' => '邮箱格式错误',
    ];
}
