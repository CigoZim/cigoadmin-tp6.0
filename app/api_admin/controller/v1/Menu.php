<?php
declare (strict_types=1);

namespace app\api_admin\controller\v1;

use app\api_admin\controller\CommonV1;
use app\api_admin\library\ApiErrorCode;
use app\api_admin\library\ApiHttpReponseCode;
use app\cigo_admin_core\controller\Manager;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;

class Menu extends CommonV1
{
    use Manager;

    /**
     * 获取树形菜单
     * @return false|mixed|string
     */
    public function index()
    {
        try {
            return $this->menuTree();
        } catch (DataNotFoundException $e) {
        } catch (ModelNotFoundException $e) {
        } catch (DbException $e) {
            return $this->makeApiReturn('服务器错误', [], ApiErrorCode::ServerError_DB_ERROR,ApiHttpReponseCode::ServerError_InternalServer_Error);
        }
    }

    /**
     * 获取基础菜单数据
     * @return mixed
     */
    public function base(){
        try {
            return $this->menuBase();
        } catch (DataNotFoundException $e) {
        } catch (ModelNotFoundException $e) {
        } catch (DbException $e) {
            return $this->makeApiReturn('服务器错误', [], ApiErrorCode::ServerError_DB_ERROR,ApiHttpReponseCode::ServerError_InternalServer_Error);
        }
    }

    public function both(){
        try {
            return $this->menuBoth();
        } catch (DataNotFoundException $e) {
        } catch (ModelNotFoundException $e) {
        } catch (DbException $e) {
            return $this->makeApiReturn('服务器错误', [], ApiErrorCode::ServerError_DB_ERROR,ApiHttpReponseCode::ServerError_InternalServer_Error);
        }
    }
}
