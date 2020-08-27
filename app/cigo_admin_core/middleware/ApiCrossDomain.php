<?php
declare (strict_types=1);

namespace app\cigo_admin_core\middleware;

use Closure;
use think\Request;
use think\Response;

/**
 * 跨域检查
 *
 * Class ApiCrossDomain
 * @package app\cigo_admin_core\middleware
 */
class APiCrossDomain
{
    protected $header = [
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Allow-Credentials' => 'true',
        'Access-Control-Allow-Headers' => 'Cigo-Device-Type, Cigo-Timestamp, Cigo-Token, Cigo-Sign, Origin, X-Requested-With,Content-Type, Accept, Authorization',
        'Access-Control-Allow-Methods' => 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    ];

    /**
     * 允许跨域请求
     * @access public
     * @param Request $request
     * @param Closure $next
     * @param array $header
     * @return Response
     */
    public function handle($request, Closure $next, ?array $header = [])
    {
        $header = empty($header) ? $this->header : array_merge($this->header, $header);

        if ($request->method(true) == 'OPTIONS') {
            return Response::create()->code(204)->header($header);
        }

        return $next($request)->header($header);
    }
}
