<?php

namespace app\cigo_admin_core\library\uploader\file;

use app\cigo_admin_core\library\uploader\FileType;
use app\cigo_admin_core\library\uploader\Uploader;

/**
 * 文件上传接口
 *
 * Class File
 * @package app\common\library\uploader
 */
class File extends Uploader
{

    protected function getConfigFileLimit($configs)
    {
        return $configs['fileLimit']['file'];
    }

    protected function getFileType()
    {
        return FileType::FILE;
    }
}

