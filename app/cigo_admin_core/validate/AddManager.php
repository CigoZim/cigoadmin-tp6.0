<?php
declare (strict_types=1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class AddManager extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'    =>    ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'role_flag' => 'require|in:2,4',
        'username' => 'require',
        'password' => 'require',
        'email' => 'require|email',
        'auth_group' => 'array',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */
    protected $message = [
        'role_flag.require' => '请提供管理员类型',
        'role_flag.in' => '管理员类型错误',
        'username.require' => '请提供用户名',
        'password.require' => '请提供密码',
        'email.require' => '请提供邮箱',
        'email.email' => '邮箱格式错误',
        'auth_group.array' => '角色格式错误',
    ];
}
