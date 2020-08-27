<?php
declare (strict_types=1);

namespace app\cigo_admin_core\library\traites;

use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;

/**
 * 参数检查Trait
 *
 * Trait CheckArgs
 * @package app\cigo_admin_core\library\traites
 */
trait CheckArgs
{
    use ApiCommon;

    /**
     * 检查接口时间戳
     */
    protected function checkTimeStamp()
    {
        if (empty($this->request->header("Cigo-Timestamp")) ||
            intval($this->request->header("Cigo-Timestamp")) <= 1 ||
            strlen($this->request->header("Cigo-Timestamp")) !== 10) {
            abort($this->makeApiReturn(
                "时间戳错误", [],
                ErrorCode::ApiCheck_TimeStampError,
                HttpReponseCode::ClientError_BadRequest
            ));
        }

        if (abs(time() - intval($this->request->header("Cigo-Timestamp"))) > 60) {
            abort($this->makeApiReturn(
                "请求超时", [],
                ErrorCode::ApiCheck_TimeStampError,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
    }

    /**
     * 检查接口签名
     */
    protected function checkSign()
    {
        if ($this->request->header("Cigo-Sign") == null) {
            abort($this->makeApiReturn(
                "请提供参数签名", [],
                ErrorCode::ApiCheck_SignError,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
        //TODO 核对签名
        $sign = $this->createSign();
        if (env('cigo_admin.check_sign', true) && $this->request->header("Cigo-Sign") != $sign) {
            abort($this->makeApiReturn(
                "签名错误", [],
                ErrorCode::ApiCheck_SignError,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
    }

    /**
     * 生成签名
     */
    protected function createSign()
    {
        $sign_data = input();
        unset($sign_data['version']);
        ksort($sign_data);
        $sign_data_str = http_build_query($sign_data);
//        abort($this->makeApiReturn(
//            '1111', [
//                $sign_data,
//                $sign_data_str,
//                md5($sign_data_str)
//            ]
//        ));
        return md5($sign_data_str);
    }
}
