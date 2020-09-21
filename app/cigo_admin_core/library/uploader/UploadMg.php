<?php

namespace app\cigo_admin_core\library\uploader;

use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\library\traites\ApiCommon;
use think\facade\Config;

/**
 * 上传类
 * 负责文件的上传处理
 */
class UploadMg
{
    use ApiCommon;

    private $args = false;
    private $files = false;
    private $configs = false;

    private $fileUploader = null;

    /**
     * 初始化上传管理类
     * @param bool $args
     * @param bool $files
     * @param bool $configs
     * @return $this
     */
    public function init($args = false, $files = false, $configs = false)
    {
        if (!$args) {
            $this->args = input();
        }
        if (!$files) {
            $this->files = $_FILES;
        }
        if (!$configs) {
            $this->configs = Config::get('cigo.file_upload');
        }

        return $this;
    }

    /**
     * 创建上传实例
     */
    public function makeFileUploader()
    {
        if (!isset($this->args['fileType']) || empty($this->args['fileType'])) {
            abort($this->makeApiReturn(
                "参数错误", $this->args,
                ErrorCode::ClientError_ArgsWrong,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
        $fileUpCls = 'app\\cigo_admin_core\\library\\uploader\\file\\' . ucfirst($this->args['fileType']);
        $this->fileUploader = new $fileUpCls();
        if (!$this->fileUploader) {
            $fileUpCls = 'app\\cigo_admin_core\\library\\uploader\\file\\File';
            $this->fileUploader = new $fileUpCls();
        }
        //初始化文件上传类
        $this->fileUploader->init($this->args, $this->configs);
    }

    /**
     * @param string $fileName 上传文件名称
     */
    function doUpload($fileName = 'upload')
    {
        $file = $this->files[$fileName];
        $this->upload($file);
    }

    /**
     * @param $file
     */
    private function upload($file)
    {
        //1. 检查上传文件
        $this->checkUploadFile($file);

        //2. 检查上传文件配置限制
        $this->fileUploader->checkConfigs($file, $this->configs);

        //3. 上传文件
        $this->fileUploader->upload($this->args, $file, $this->configs);
    }

    private function checkUploadFile(&$file)
    {
        // 检查是否存在上传错误
        if ($file['error']) {
            abort($this->makeApiReturn(
                $this->checkUploadErrorNo($file['error']), [],
                ErrorCode::ClientError_ArgsWrong,
                HttpReponseCode::ClientError_BadRequest
            ));
        }

        // 无效上传
        if (empty($file['name'])) {
            abort($this->makeApiReturn(
                "上传文件名为空！", [],
                ErrorCode::ClientError_ArgsWrong,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
        // 检查上传临时文件是否合法
        if (!is_uploaded_file($file['tmp_name'])) {
            abort($this->makeApiReturn(
                "非法上传文件！", [],
                ErrorCode::ClientError_ArgsWrong,
                HttpReponseCode::ClientError_BadRequest
            ));
        }

        // 补齐上传文件信息
        $this->addInfoToUploadFile($file);
    }

    private function addInfoToUploadFile(&$file)
    {
        $file['ext'] = pathinfo($file['name'], PATHINFO_EXTENSION);
        $file['md5'] = md5_file($file['tmp_name']);
        $file['sha1'] = sha1_file($file['tmp_name']);
    }

    private function checkUploadErrorNo($errorNo)
    {
        switch ($errorNo) {
            case 1:
                $errorMsg = '上传的文件超过了php配置限制！';
                break;
            case 2:
                $errorMsg = '上传文件的大小超过了表单限制！';
                break;
            case 3:
                $errorMsg = '文件只有部分被上传！';
                break;
            case 4:
                $errorMsg = '没有文件被上传！';
                break;
            case 6:
                $errorMsg = '找不到临时文件夹！';
                break;
            case 7:
                $errorMsg = '文件写入失败！';
                break;
            default:
                $errorMsg = '未知上传错误！';
        }
        return $errorMsg;
    }
}
