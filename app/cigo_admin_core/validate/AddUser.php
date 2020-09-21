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
        'realname' => 'require',
        'sex' => 'require|in:0,1,2',
        'phone' => 'require|mobile',
        'hospital' => 'require',
        'department_id' => 'require|number',
        'professional_id' => 'require|number',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */
    protected $message = [
        'username.require' => '请提供用户名',
        'realname.require' => '请提供真实姓名',
        'sex.require' => '请设置性别',
        'sex.in' => '性别错误',
        'phone.require' => '请提供手机号',
        'phone.mobile' => '手机号格式错误',
        'hospital.require' => '请填写医院',
        'department_id.require' => '请选择科室',
        'department_id.number' => '科室错误',
        'professional_id.require' => '请选择职称',
        'professional_id.number' => '职称错误',
    ];
}
