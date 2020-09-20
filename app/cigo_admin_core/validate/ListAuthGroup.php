<?php
declare (strict_types=1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class ListAuthGroup extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'    =>    ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'module' => 'require'
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */
    protected $message = [
        'module.require' => '为提供所属模块',
    ];
}
