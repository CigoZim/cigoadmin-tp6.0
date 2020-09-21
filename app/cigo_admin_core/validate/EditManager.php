<?php
declare (strict_types=1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class EditManager extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'    =>    ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'id' => 'require:number',
        'role_flag' => 'in:2,4',
        'email' => 'email',
        'auth_group' => 'array',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */
    protected $message = [
        'id.require' => '未提供管理员编号',
        'id.number' => '管理员编号错误',
        'role_flag.in' => '管理员类型错误',
        'email.email' => '邮箱格式错误',
        'auth_group.array' => '角色格式错误',
    ];
}
