<?php
declare (strict_types=1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class EditUser extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'    =>    ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'id' => 'require:number',
        'sex' => 'require|in:0,1,2',
        'phone' => 'mobile',
        'department_id' => 'number',
        'professional_id' => 'number',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */
    protected $message = [
        'id.require' => '未提供用户编号',
        'id.number' => '用户编号错误',
        'sex.in' => '性别错误',
        'phone.mobile' => '手机号格式错误',
        'department_id.number' => '科室错误',
        'professional_id.number' => '职称错误',
    ];
}
