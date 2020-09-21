<?php
declare (strict_types=1);

namespace app\api_admin\controller\v1;

use app\api_admin\controller\CommonV1;
use app\api_admin\library\ApiErrorCode;
use app\api_admin\library\ApiHttpReponseCode;
use app\cigo_admin_core\controller\Manager as TraitManager;
use Think\Exception;

class Manager extends CommonV1
{
    use TraitManager;

    public function login()
    {
        try {
            return $this->doLogin();
        } catch (Exception $e) {
            return $this->makeApiReturn('服务器内部错误', [], ApiErrorCode::ServerError_OTHER_ERROR, ApiHttpReponseCode::ServerError_InternalServer_Error);
        }
    }

    public function addManager(){
        return $this->add();
    }

    public function editManager(){
        return $this->edit();
    }

    public function statusManager(){
        return $this->setStatus();
    }

    public function getManagerList(){

    }
}