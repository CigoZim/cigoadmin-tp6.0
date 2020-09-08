<?php

namespace app\cigo_admin_core\library\uploader\traites;

use app\cigo_admin_core\library\traites\ApiCommon;
use app\cigo_admin_core\library\uploader\UploadMg;

/**
 * Trait UploadLocal
 * @package app\cigo_admin_core\library\traites
 * @summary 负责后台管理中的文件本地服务器上传操作
 */
trait UploadLocal
{
    use ApiCommon;

    /**
     * 文件上传
     */
    private function upload()
    {
        //1. 实例化上传类，并创建文件上传实例
        $upMg = new UploadMg();
        $upMg->init()->makeFileUploader();

        //2. 执行上传操作
        $upMg->doUpload();
    }
}
