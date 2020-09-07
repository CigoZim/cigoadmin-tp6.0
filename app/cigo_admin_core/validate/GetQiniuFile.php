<?php
declare (strict_types=1);

namespace app\cigo_admin_core\validate;

use app\cigo_admin_core\library\ApiBaseValidate;

class GetQiniuFile extends ApiBaseValidate
{
    /**
     * 定义验证规则
     * 格式：'字段名'    =>    ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'bucket' => 'require|in:open,img,video',
        'fileKey' => 'require',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */
    protected $message = [
        'bucket.require' => '请提供空间类型',
        'bucket.in' => '空间类型错误',
        'fileKey.require' => '请提供七牛云文件标识',
    ];
}
