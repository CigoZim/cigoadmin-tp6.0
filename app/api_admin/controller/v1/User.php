<?php
declare (strict_types=1);

namespace app\api_admin\controller\v1;

use app\api_admin\controller\CommonV1;
use app\cigo_admin_core\controller\User as TraitUser;

class User extends CommonV1
{
    use TraitUser;

    public function addUser(){
        return $this->add();
    }

    public function editUser(){
        return $this->edit();
    }

    public function statusUser(){
        return $this->setStatus();
    }

    public function getUserList(){
        return $this->getList();
    }
}