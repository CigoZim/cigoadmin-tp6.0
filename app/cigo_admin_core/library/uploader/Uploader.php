<?php

namespace app\cigo_admin_core\library\uploader;

use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\library\traites\ApiCommon;
use app\cigo_admin_core\library\traites\Common;
use app\cigo_admin_core\model\Files;

/**
 * 上传文件类
 * 负责铁定文件的上传处理
 */
abstract class Uploader
{
    use ApiCommon;
    use Common;

    private $maxSize = 0;
    private $exts = array();

    function init($args, $configs)
    {
        $this->initFileLimit($args, $configs);
    }

    protected function initFileLimit($args, $configs)
    {
        $fileLimit = $this->getConfigFileLimit($configs);

        //限制文件大小
        $this->maxSize = (isset($fileLimit['maxSize']) && is_numeric($fileLimit['maxSize']))
            ? $fileLimit['maxSize']
            : 0;
        //限制文件后缀
        $exts = (isset($fileLimit['exts']) && !empty($fileLimit['exts']))
            ? $fileLimit['exts']
            : '';
        $exts = preg_replace('# #', '', trim(strtolower($exts)));
        $this->exts = explode(',', $exts);
    }

    protected abstract function getConfigFileLimit($configs);

    protected abstract function getFileType();

    public function checkConfigs($file, $configs)
    {
        //1. 检查大小限制
        if (($this->maxSize == 0) || ($file["size"] > $this->maxSize)) {
            abort($this->makeApiReturn(
                '文件大小超出限制(' . ($this->maxSize / 1024 / 1024) . 'M)', [],
                ErrorCode::ClientError_ArgsWrong,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
        //2. 检查文件后缀
        if (!$this->exts || !count($this->exts) || !in_array(strtolower($file['ext']), $this->exts)) {
            abort($this->makeApiReturn(
                "上传文件后缀错误", [],
                ErrorCode::ClientError_ArgsWrong,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
    }

    public function upload($args, $file, $configs)
    {
        //1. 保存上传文件
        $this->saveUploadFile($args, $file, $configs);

        //2. 处理上传文件
        $this->ctrlUploadFile($args, $file, $configs);
    }

    protected function saveUploadFile($args, &$file, $configs)
    {
        // 检查文件是否存在且保存于数据库中
        $dbInfo = $this->getUploadFileInDB($file);
        // 确保文件保存到磁盘
        $this->saveUploadFileToDisk($dbInfo, $file, $configs);

        // 确保文件保存到数据库
        $this->saveUploadFileToDb($dbInfo, $file);
    }

    /**
     * @param $dbInfo
     * @param $file
     * @param $configs
     */
    private function saveUploadFileToDisk($dbInfo, &$file, $configs)
    {
        if ($dbInfo && is_file($dbInfo['path'])) {
            $file['ext'] = pathinfo($dbInfo['path'], PATHINFO_EXTENSION);

            $file['saved_path'] = pathinfo($dbInfo['path'], PATHINFO_DIRNAME);
            $file['saved_name'] = pathinfo($dbInfo['path'], PATHINFO_FILENAME);
            $file['saved_path_name'] = $dbInfo['path'];
            return;
        } else {
            $file['root_path'] = $configs['rootPath'];
            $file['sub_path'] = $this->getSubPath();

            $file['saved_path'] = $file['root_path'] . '/' . $file['sub_path'];//TODO 注意路径'./',避免linux造成'./'和'/'歧义
            $file['saved_name'] = $this->getSaveFileName();
            $file['saved_path_name'] = $file['saved_path'] . '/' . $file['saved_name'] . '.' . $file['ext'];

            //检查是否允许覆盖
            if (!$configs['replace'] && is_file($file['saved_path_name'])) {
                abort($this->makeApiReturn(
                    "保存文件重名，请重新尝试", [],
                    ErrorCode::ClientError_ArgsWrong,
                    HttpReponseCode::ClientError_BadRequest
                ));
            }
        }
        //检查保存目录是否存在
        $this->mkPath($file['saved_path']);

        //检查保存目录是否可写
        $this->checkPathWritable($file['saved_path']);

        if (!move_uploaded_file($file['tmp_name'], $file['saved_path_name'])) {
            abort($this->makeApiReturn(
                "上传文件保存错误", [],
                ErrorCode::ServerError_PATH_AUTH,
                HttpReponseCode::ServerError_InternalServer_Error
            ));
        }
    }

    protected function mkPath($path)
    {
        if (is_dir($path)) {
            if (!is_writable($path)) {
                abort($this->makeApiReturn(
                    "上传目录不可写", [],
                    ErrorCode::ServerError_PATH_AUTH,
                    HttpReponseCode::ServerError_InternalServer_Error
                ));
            }
            return;
        }
        if (!mkdir($path, 0777, true)) {
            abort($this->makeApiReturn(
                '目录 {' . $path . '} 创建失败！！', [],
                ErrorCode::ServerError_PATH_AUTH,
                HttpReponseCode::ServerError_InternalServer_Error
            ));
        }
    }

    protected function checkPathWritable($path)
    {
        /* 检测目录是否可写 */
        if (!is_writable($path)) {
            abort($this->makeApiReturn(
                '上传目录{' . $path . '}不可写！', [],
                ErrorCode::ServerError_PATH_AUTH,
                HttpReponseCode::ServerError_InternalServer_Error
            ));
        }
    }

    private function saveUploadFileToDb($dbInfo, &$file)
    {
        if ($dbInfo && is_file($dbInfo['path'])) {
            $file['id'] = $dbInfo['id'];
            return;
        }
        $data = array(
            'type' => $this->getFileType(),
            'name' => $file['name'],
            'name_saved' => $file['saved_name'],
            'ext' => $file['ext'],
            'mime' => $file['type'],
            'path' => $file['saved_path_name'],
            'md5' => $file['md5'],
            'sha1' => $file['sha1']
        );
        try {
            if ($dbInfo) {
                $file['id'] = $dbInfo['id'];
                Files::update($data, ['id' => $dbInfo['id']]);
            } else {
                $fileModel = Files::create($data);
                $file['id'] = intval($fileModel->id);
            }

        } catch (\Exception $exception) {
            abort($this->makeApiReturn(
                "保存数据库失败", [],
                ErrorCode::ServerError_DB_ERROR,
                HttpReponseCode::ServerError_InternalServer_Error
            ));
            return;
        }
    }

    private function getUploadFileInDB(&$file)
    {
        return Files::where(array('md5' => $file['md5'], 'sha1' => $file['sha1']))->find();
    }

    protected function getSaveFileName()
    {
        return time() . $this->randomFileNameExt();
    }

    function randomFileNameExt()
    {
        $srcStr = "abcdefghijklmnpqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ123456789";
        $desStr = "";
        for ($i = 0; $i < 5; $i++) {
            $desStr .= $srcStr[mt_rand(0, strlen($srcStr) - 1)];
        }
        return $desStr;
    }

    protected function getSubPath()
    {
        return date('Y-m-d', time());
    }

    protected function ctrlUploadFile($args, $file, $configs)
    {
        abort($this->makeApiReturn(
            "上传上传成功", $this->getResponseFileInfo($file),
            ErrorCode::OK,
            HttpReponseCode::Success_OK
        ));
    }

    protected function getResponseFileInfo($file)
    {
        return array(
            'id' => $file['id'],
            'name' => $file['name'],
            'name_saved' => $file['saved_name'],
            'ext' => $file['ext'],
            'path' => trim($file['saved_path_name'], '.'),
            'url' => $this->getUploadFileUrl(trim($file['saved_path_name'], '.'))
        );
    }
}
