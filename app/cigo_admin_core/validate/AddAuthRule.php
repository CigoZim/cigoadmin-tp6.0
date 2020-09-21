<?php
declare (strict_types=1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class AddAuthRule extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'    =>    ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'title' => 'require',
        'component_name' => 'require|unique:user_mg_auth_rule',
        'url' => 'require',
        'pid' => 'require',
        'path' => 'require',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */
    protected $message = [
        'title.require' => '请配置节点名称',
        'component_name.require' => '请配置组件名',
        'component_name.unique' => '组件名需保持唯一',
        'url.require' => '请配置节点路由',
        'pid.require' => '未提供pid',
        'path.require' => '未提供path',
    ];
}
