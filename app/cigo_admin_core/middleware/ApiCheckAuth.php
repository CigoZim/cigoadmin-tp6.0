<?php
declare (strict_types=1);

namespace app\cigo_admin_core\middleware;

use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\library\traites\ApiCommon;
use app\cigo_admin_core\model\User;
use Closure;
use think\Request;
use think\Response;

/**
 * 检查权限
 *
 * Class ApiCheckAuth
 * @package app\cigo_admin_core\middleware
 */
class ApiCheckAuth
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
        $request->token = $request->header('Cigo-Token');
        if (empty($request->token)) {
            abort($this->makeApiReturn(
                '参数：无token', [],
                ErrorCode::ClientError_TokenError,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
        $userInfo = User::where([
            ['token', '=', $request->token],
            ['status', '=', 1]
        ])
            ->with([
                'studentInfo' => function ($query) {
                    $query->append(['img_middle_url']);
                },
                'coachInfo' => function ($query) {
                    $query->append(['img_middle_url']);
                }
            ])
            ->findOrEmpty();
        if ($userInfo->isEmpty()) {
            abort($this->makeApiReturn(
                '无此用户或禁用', ['token' => $request->token],
                ErrorCode::ClientError_TokenError,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
        $request->userInfo = $userInfo;

        return $next($request);
    }
}
