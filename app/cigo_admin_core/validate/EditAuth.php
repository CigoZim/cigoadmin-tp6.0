<?php
declare (strict_types = 1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class EditAuth extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'	=>	['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'id'=>'require',
        'title'=>'require',
        'url'=>'require',
        'pid'=>'require',
        'path'=>'require',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'	=>	'错误信息'
     *
     * @var array
     */
    protected $message = [
        'id.require'=>'未提供id',
        'title.require'=>'请配置节点名称',
        'url.require'=>'请配置节点路由',
        'pid.require'=>'未提供pid',
        'path.require'=>'未提供path',
    ];
}
