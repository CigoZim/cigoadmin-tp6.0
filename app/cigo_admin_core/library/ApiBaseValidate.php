<?php

namespace app\cigo_admin_core\library;

use app\cigo_admin_core\library\traites\ApiCommon;
use think\facade\Request;
use think\Validate;

/**
 * Api验证器基类
 *
 * Class ApiBaseValidate
 * @package app\cigo_admin_core\library
 */
class ApiBaseValidate extends Validate
{
    use ApiCommon;

    /**
     * 获取新实例
     *
     * @return static
     */
    public static function instance()
    {
        return new static();
    }

    public function runCheck()
    {
        $request = Request::instance();
        if ($this->check(input()) == false) {
            abort($this->makeApiReturn(
                $this->getError(), [],
                ErrorCode::ClientError_ArgsWrong,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
    }
}