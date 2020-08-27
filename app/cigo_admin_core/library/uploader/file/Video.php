<?php

namespace app\cigo_admin_core\library\uploader\file;

use app\cigo_admin_core\library\uploader\FileType;
use app\cigo_admin_core\library\uploader\Uploader;

/**
 * 视频上传接口
 *
 * Class Video
 * @package app\common\library\uploader
 */
class Video extends Uploader
{
    protected function getConfigFileLimit($configs)
    {
        return $configs['fileLimit']['video'];
    }

    protected function getFileType()
    {
        return FileType::VIDEO;
    }
}

