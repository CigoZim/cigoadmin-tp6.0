<?php
declare (strict_types=1);

namespace app\cigo_admin_core\model;

use think\Model;

/**
 * 用户模型
 * Class User
 * @package app\cigo_admin_core\model
 */
class User extends Model
{
    const  ROLE_FLAGS_COMMON_USER = 1;
    const  ROLE_FLAGS_MAIN_ADMIN = 2;
    const  ROLE_FLAGS_COMMON_ADMIN = 4;
}
