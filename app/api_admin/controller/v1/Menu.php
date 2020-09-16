<?php
declare (strict_types=1);

namespace app\api_admin\controller\v1;

use app\api_admin\controller\CommonV1;
use app\cigo_admin_core\controller\Manager;

class Menu extends CommonV1
{
    use Manager;

    public function index()
    {
            return $this->menuTree();
    }

    public function base(){
        return $this->menuBase();
    }

    public function both(){
       return $this->menuBoth();
    }
}
