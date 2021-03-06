<?php
declare (strict_types=1);

namespace app\cigo_admin_core\library\traites;

/**
 * Api接口基类公共方法
 *
 * Trait ApiCommon
 * @package app\cigo_admin_core\library\traites
 */
trait ApiCommon
{
    /**
     * 封装统一返回数据格式
     *
     * @param string $msg
     * @param array $data
     * @param int $errorcode
     * @param int $httpcode
     * @return false|string
     */
    protected function makeApiReturn($msg = "ok", $data = [], $errorcode = 0, $httpcode = 200)
    {
        $msg_data = [
            "msg" => $msg,
            "data" => $data,
            "error_code" => $errorcode
        ];
        return json($msg_data, $httpcode);
    }

    protected function makeStatusTips()
    {
        $tips = '';
        switch ($this->args['status']) {
            case 0:
                $tips = '禁用成功';
                break;
            case 1:
                $tips = '启用成功';
                break;
            case -1:
                $tips = '删除成功';
                break;
        }
        return $tips;
    }
}