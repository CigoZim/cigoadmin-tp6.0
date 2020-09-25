<?php
declare (strict_types=1);

namespace app\cigo_admin_core\model;

use think\Model;

/**
 * Class UserMgAuthGroup
 * @package app\cigo_admin_core\model
 */
class UserMgAuthGroup extends Model
{
    protected $table = 'cg_user_mg_auth_group';

    public function getRulesAttr($value, $data)
    {
        return json_decode($data['rules'], true);
    }
}
