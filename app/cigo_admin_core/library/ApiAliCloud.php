<?php

namespace app\cigo_admin_core\library;

use AlibabaCloud\Client\Exception\ClientException;
use AlibabaCloud\Client\Exception\ServerException;
use app\cigo_admin_core\library\traites\ApiCommon;
use think\facade\Cache;
use think\facade\Log;

/**
 * Api接口基准类
 *
 * Class AliCloudApi
 * @package app\api\library
 */
class ApiAliCloud extends AliCloud
{
    use ApiCommon;

    /**
     * 发送短信验证码
     *
     * @param $phone
     * @param string $code
     * @return array|bool
     */
    public function sendSmsCode($phone, $code = "")
    {
        try {
            $this->msgCode = empty($code) ? $this->msgCode : $code;
            empty($this->msgCode) ? $this->createCode() : false;

            $result = parent::sendSmsCode($phone, $this->msgCode);

            //发送成功
            if ($result["Code"] == "OK") {
                //短信发送成功存入缓存，并设置超时时间
                Cache::set($this->codeCachePrefix . $phone, $this->msgCode, $this->expireTime);
                return true;
            }
            //发送错误
            Log::record($phone . ':' . $result["Message"], \think\Log::NOTICE);
            abort($this->makeApiReturn(
                $result['Message'], [],
                ErrorCode::ServerError_AliCloudSendMsg,
                HttpReponseCode::ServerError_InternalServer_Error
            ));
        } catch (ClientException $exception) {
            Log::record($phone . ':' . $exception->getErrorMessage(), \think\Log::NOTICE);
            abort($this->makeApiReturn(
                "短信服务异常", [],
                ErrorCode::ServerError_AliCloudSendMsg,
                HttpReponseCode::ServerError_InternalServer_Error
            ));
        } catch (ServerException $exception) {
            Log::record($phone . ':' . $exception->getErrorMessage(), \think\Log::NOTICE);
            abort($this->makeApiReturn(
                "短信服务异常", [],
                ErrorCode::ServerError_AliCloudSendMsg,
                HttpReponseCode::ServerError_InternalServer_Error
            ));
        }
    }

    /**
     * 核对短信验证码
     *
     * @param $phone
     * @param $code
     * @return bool
     */
    public function checkCode($phone, $code)
    {
        // 获取、核对、清空缓存验证码
        if ($code == Cache::pull($this->codeCachePrefix . $phone)) {
            return true;
        }
        return false;
    }
}