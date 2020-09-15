<?php
declare (strict_types=1);

namespace app\api_admin\controller\v1;

use app\api_admin\controller\CommonV1;
use app\cigo_admin_core\controller\UploadCloud;

class Qiniu extends CommonV1
{
    use UploadCloud;

    public function token()
    {
        return $this->makeQiniuyunToken();
    }
}