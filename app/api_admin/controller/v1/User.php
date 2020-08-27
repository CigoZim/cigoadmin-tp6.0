<?php
declare (strict_types = 1);

namespace app\api_admin\controller\v1;

use app\api_admin\controller\CommonV1;

class User extends CommonV1
{
    public function login(){
        dump($this->args);
    }
}
