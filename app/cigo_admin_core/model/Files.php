<?php

namespace app\cigo_admin_core\model;

use app\cigo_admin_core\library\traites\Common;
use think\Model;

class Files extends Model
{
    use Common;

    protected $auto = [];
    protected $insert = ['status' => 1, 'create_ip' => 0];
    protected $update = [];
    protected $append = ['url', 'url_thumb_small', 'url_thumb_middle'];

    public function getUrlAttr($value, $data)
    {
        return $this->getUploadFileUrl(trim($data['path'], '.'));
    }

    public function getUrlThumbSmallAttr($value, $data)
    {
        return $this->getUploadFileUrl(trim($data['thumb_small'], '.'));
    }

    public function getUrlThumbMiddleAttr($value, $data)
    {
        return $this->getUploadFileUrl(trim($data['thumb_middle'], '.'));
    }

}
