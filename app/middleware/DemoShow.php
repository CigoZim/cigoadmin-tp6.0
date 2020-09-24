<?php
declare (strict_types=1);

namespace app\middleware;

use app\api_admin\library\ApiErrorCode;
use app\api_admin\library\ApiHttpReponseCode;
use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\library\traites\ApiCommon;
use Closure;
use think\Request;
use think\Response;

class DemoShow
{
    use ApiCommon;

    /**
     * 处理请求
     *
     * @param Request $request
     * @param Closure $next
     * @return Response
     */
    public function handle($request, Closure $next)
    {
        if (env('cigo_admin.demo_show')) {
            abort($this->makeApiReturn(
                '当前为演示版，避免影响其他人查看，请勿修改',
                [],
                ApiErrorCode::ServerError_OTHER_ERROR,
                ApiHttpReponseCode::ClientError_Forbidden
            ));
        }
        return $next($request);
    }
}
