<?php

namespace app\cigo_admin_core\library;

/**
 * Http相应状态码
 *
 * Class HttpReponseStatus
 * @package app\cigo_admin_core\library
 */
class HttpReponseCode
{
    const Success_OK = 200; // 请求成功
    const Success_Created = 201; // 请求成功，新资源建立
    const Success_Accept = 202; // 请求成功
    const Success_NoContent = 204; // 请求成功,没有内容

    const Redirect_MultipleChoices = 300; // 存在多个资源
    const Redirect_MovedPermanently = 301; // 资源被永转移
    const Redirect_Found = 302; // 请求的资源被暂时转移
    const Redirect_SeeOther = 303; // 引用他处

    const ClientError_BadRequest = 400; // 请求不正确
    const ClientError_Unauthorized = 401;// 需要认证
    const ClientError_Forbidden = 403; // 禁止访问
    const ClientError_NotFound = 404; // 没有找到指定的资源
    const ClientError_TooManyRequests = 429; // 访问次数过多

    const ServerError_InternalServer_Error = 500; // 服务器端发生错误
    const ServerError_ServerClose = 503; // 服务器暂时停止运营
}

