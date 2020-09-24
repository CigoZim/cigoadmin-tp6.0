<?php
declare (strict_types=1);

namespace app\cigo_admin_core\library\traites;

use app\cigo_admin_core\model\Files;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\facade\Env;
use think\facade\Request;
use think\Model;

/**
 * 公共函数trait
 *
 * Trait Common
 * @package app\cigo_admin_core\library\traites
 */
trait Common
{
    /**
     * 获取上传文件路径
     * @param int $fileId
     * @param string $field
     * @param Model $model
     * @return array|string|Model|null
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function getUploadFilePath($fileId = 0, $field = 'path', $model = null)
    {
        if (empty($fileId)) {
            return '';
        }
        $model = null == $model ? new Files() : $model;
        $data = $model
            ->where([
                ['id', '=', $fileId],
                ['status', '=', 1]
            ])
            ->find();
        if (!$data) {
            return '';
        }
        return empty($field) ? $data : trim($data[$field], '.');
    }

    /**
     * 获取上传文件Url地址
     * @param string $path 图片path
     * @param bool $isCdn
     * @return string 图片url
     */
    protected function getUploadFileUrl($path, $isCdn = true)
    {

        if (empty($path)) {
            return '';
        }
        switch ($path) {
            case 'http://' === substr($path, 0, 7):
            case 'https://' === substr($path, 0, 8):
                break;
            default:
                //TODO byzim
                $path = Request::scheme()."://" . (
                    $isCdn
                        ? Env::get('server.app_cdn_domain')
                        : Env::get('server.app_domain')
                    ) . $path;
                break;
        }
        return $path;
    }
}
