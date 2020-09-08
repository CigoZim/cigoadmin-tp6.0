<?php
declare (strict_types=1);

namespace app\api_admin\controller\v1;

use app\api_admin\library\ApiBase;
use app\cigo_admin_core\library\uploader\traites\UploadCloud;

class Notify extends ApiBase
{
    use UploadCloud;

    /**
     * 七牛云文件上传通知
     */
    public function qiniu()
    {
        return $this->qiniuNotify();
    }
}
