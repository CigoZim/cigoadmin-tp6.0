<?php

namespace app\cigo_admin_core\library;

/**
 * 错误码
 *
 * Class ErrorCode
 * @package app\cigo_admin_core\library
 */
class ErrorCode
{
    /**
     * 操作成功，无错误
     */
    const OK = 0;

    /**
     * 接口检查
     */
    const ApiCheck_TimeStampError = 10001; // 时间戳错误
    const ApiCheck_SignError = 10002; // 接口签名错误

    /**
     * 系统错误类
     */
    const ServerError_AliCloudSendMsg = 20001; // 阿里短信发送错误
    const ServerError_PATH_AUTH = 20002; // 服务器目录权限问题
    const ServerError_DB_ERROR = 20003; // 服务器数据库错误

    /**
     * 终端错误
     */
    const ClientError_ArgsWrong = 30001; // 参数错误
    const ClientError_TokenError = 30002; // Token无效
    const ClientError_AuthError = 30003; // 权限错误

    /**
     * 分支操作
     */
    const MoreCtrl_NeedBindPhone = 40001; // 需绑定手机号码

}

