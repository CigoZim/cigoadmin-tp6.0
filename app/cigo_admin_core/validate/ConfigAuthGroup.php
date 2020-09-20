<?php
declare (strict_types=1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class ConfigAuthGroup extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'    =>    ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'id' => 'require',
        'rules' => 'require',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */
    protected $message = [
        'id.require' => '未提供编号',
        'rules.require' => '请选择权限节点',
    ];
}
