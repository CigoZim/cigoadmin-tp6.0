<?php

namespace app\cigo_admin_core\library\uploader\file;

use app\cigo_admin_core\library\ErrorCode;
use app\cigo_admin_core\library\HttpReponseCode;
use app\cigo_admin_core\library\uploader\FileType;
use app\cigo_admin_core\library\uploader\Uploader;
use app\cigo_admin_core\model\Files;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Image;

/**
 * 图片上传接口
 *
 * Class Img
 * @package app\common\library\uploader
 */
class Img extends Uploader
{
    const CTRL_TYPES_THUMB = 'thumb';
    const CTRL_TYPES_CROP = 'crop';
    const CTRL_TYPES_WATER = 'water';
    const CTRL_TYPES_TXT = 'text';

    protected function getConfigFileLimit($configs)
    {
        return $configs['fileLimit']['img'];
    }

    protected function getFileType()
    {
        return FileType::IMG;
    }

    /**
     * @param $args
     * @param $file
     * @param $configs
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function ctrlUploadFile($args, $file, $configs)
    {
        // 实例化图片操作类
        $image = Image::open($file['saved_path_name']);
        // 检查操作参数
        if ($this->checkCtrlFileArgs($image, $args, $configs)) {
            // 组织保存图片信息
            $fileCtrl = array();
            $fileCtrl['name'] = $file['name'];
            $fileCtrl['ext'] = $file['ext'];
            $fileCtrl['type'] = $file['type'];
            // 保存图片至磁盘
            $this->saveCtrlFileToDisk($image, $fileCtrl, $configs);
            // 保存图片信息至数据库
            $this->saveCtrlFileToDb($fileCtrl);
            $this->makeThumb($image, $fileCtrl);
        } else {
            $this->makeThumb($image, $file);
        }
    }

    /**
     * @param Image $image
     * @param array $file
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    private function makeThumb($image, $file)
    {
        //创建默认缩略图
        $file['saved_path_name_for_thumb_middle'] = $file['saved_path'] . '/' . $file['saved_name'] . '_thumb_middle.' . $file['ext'];
        $file['saved_path_name_for_thumb_small'] = $file['saved_path'] . '/' . $file['saved_name'] . '_thumb_small.' . $file['ext'];
        $image->thumb(768, 768)->save($file['saved_path_name_for_thumb_middle']);
        $image->thumb(100, 100)->save($file['saved_path_name_for_thumb_small']);
        //更新数据库
        $data = array(
            'id' => $file['id'],
            'thumb_small' => $file['saved_path_name_for_thumb_small'],
            'thumb_middle' => $file['saved_path_name_for_thumb_middle']
        );
        $model = new Files();
        //TODO byZim
        $model->find($data['id'])->save($data);

        abort($this->makeApiReturn(
            "上传上传成功", array_merge(
            $this->getResponseFileInfo($file),
            array(
                'path_thumb_small' => trim($file['saved_path_name_for_thumb_small'], '.'),
                'url_thumb_small' => $this->getUploadFileUrl(trim($file['saved_path_name_for_thumb_small'], '.')),
                'path_thumb_middle' => trim($file['saved_path_name_for_thumb_middle'], '.'),
                'url_thumb_middle' => $this->getUploadFileUrl(trim($file['saved_path_name_for_thumb_middle'], '.'))
            )),
            ErrorCode::OK,
            HttpReponseCode::Success_OK
        ));
    }

    /**
     * @param Image $image
     * @param $args
     * @param $configs
     * @return bool
     */
    private function checkCtrlFileArgs($image, $args, $configs)
    {
        $doCtrlFlag = false;
        if (// 检查缩略图
            isset($args[Img::CTRL_TYPES_THUMB]) && !empty($args[Img::CTRL_TYPES_THUMB]) &&
            isset($args[Img::CTRL_TYPES_THUMB]['width']) && !empty($args[Img::CTRL_TYPES_THUMB]['width']) &&
            isset($args[Img::CTRL_TYPES_THUMB]['height']) && !empty($args[Img::CTRL_TYPES_THUMB]['height'])
        ) {
            $image->thumb(
                $args[Img::CTRL_TYPES_THUMB]['width'],
                $args[Img::CTRL_TYPES_THUMB]['height'],
                ((isset($args[Img::CTRL_TYPES_THUMB]['type']) && !empty($args[Img::CTRL_TYPES_THUMB]['type']))
                    ? $args[Img::CTRL_TYPES_THUMB]['type']
                    : Image::THUMB_SCALING
                )
            );
            $doCtrlFlag = true;
        } else if (// 检查截图操作
            isset($args[Img::CTRL_TYPES_CROP]) && !empty($args[Img::CTRL_TYPES_CROP]) &&
            isset($args[Img::CTRL_TYPES_CROP]['w']) && !empty($args[Img::CTRL_TYPES_CROP]['w']) &&
            isset($args[Img::CTRL_TYPES_CROP]['h']) && !empty($args[Img::CTRL_TYPES_CROP]['h']) &&
            isset($args[Img::CTRL_TYPES_CROP]['x']) && !empty($args[Img::CTRL_TYPES_CROP]['x']) &&
            isset($args[Img::CTRL_TYPES_CROP]['y']) && !empty($args[Img::CTRL_TYPES_CROP]['y'])
        ) {
            $image->crop(
                $args[Img::CTRL_TYPES_CROP]['w'],
                $args[Img::CTRL_TYPES_CROP]['h'],
                $args[Img::CTRL_TYPES_CROP]['x'],
                $args[Img::CTRL_TYPES_CROP]['y'],
                ((isset($args[Img::CTRL_TYPES_CROP]['width']) && !empty($args[Img::CTRL_TYPES_CROP]['width']))
                    ? $args[Img::CTRL_TYPES_CROP]['width']
                    : null
                ),
                ((isset($args[Img::CTRL_TYPES_CROP]['height']) && !empty($args[Img::CTRL_TYPES_CROP]['height']))
                    ? $args[Img::CTRL_TYPES_CROP]['height']
                    : null
                )
            );
            $doCtrlFlag = true;
        }
        // 检查水印图片
        if (isset($args[Img::CTRL_TYPES_WATER]) && !empty($args[Img::CTRL_TYPES_WATER])) {
            $image->water(
                $configs['waterImg'],
                ((isset($args[Img::CTRL_TYPES_WATER]['locate']) && !empty($args[Img::CTRL_TYPES_WATER]['locate']))
                    ? $args[Img::CTRL_TYPES_WATER]['locate']
                    : Image::WATER_SOUTHEAST
                ),
                ((isset($args[Img::CTRL_TYPES_WATER]['alpha']) && !empty($args[Img::CTRL_TYPES_WATER]['alpha']))
                    ? $args[Img::CTRL_TYPES_WATER]['alpha']
                    : 80
                )
            );
            $doCtrlFlag = true;
        }
        // 检查文字水印操作
        if (isset($args[Img::CTRL_TYPES_TXT]) && !empty($args[Img::CTRL_TYPES_TXT])) {
            $image->text(
                (isset($args[Img::CTRL_TYPES_TXT]['text']) && !empty($args[Img::CTRL_TYPES_TXT]['text']))
                    ? $args[Img::CTRL_TYPES_TXT]['text']
                    : ((isset($configs['waterText']) && !empty($configs['waterText']))
                    ? $configs['waterText']
                    : (!is_null(config('app_name'))
                        ? config('app_name')
                        : ''
                    )
                ),
                $configs['waterTextFont'],
                ((isset($args[Img::CTRL_TYPES_TXT]['size']) && !empty($args[Img::CTRL_TYPES_TXT]['size']))
                    ? $args[Img::CTRL_TYPES_TXT]['size']
                    : 11
                ),
                ((isset($args[Img::CTRL_TYPES_TXT]['color']) && !empty($args[Img::CTRL_TYPES_TXT]['color']))
                    ? $args[Img::CTRL_TYPES_TXT]['color']
                    : '#00000000'
                ),
                ((isset($args[Img::CTRL_TYPES_TXT]['locate']) && !empty($args[Img::CTRL_TYPES_TXT]['locate']))
                    ? $args[Img::CTRL_TYPES_TXT]['locate']
                    : Image::WATER_SOUTHEAST
                ),
                ((isset($args[Img::CTRL_TYPES_TXT]['offset']) && !empty($args[Img::CTRL_TYPES_TXT]['offset']))
                    ? $args[Img::CTRL_TYPES_TXT]['offset']
                    : 0
                ),
                ((isset($args[Img::CTRL_TYPES_TXT]['angle']) && !empty($args[Img::CTRL_TYPES_TXT]['angle']))
                    ? $args[Img::CTRL_TYPES_TXT]['angle']
                    : 0
                )
            );

            $doCtrlFlag = true;
        }
        return $doCtrlFlag;
    }

    /**
     * @param Image $image
     * @param $fileCtrl
     * @param $configs
     */
    private function saveCtrlFileToDisk($image, &$fileCtrl, $configs)
    {
        $fileCtrl['root_path'] = $configs['rootPath'];
        $fileCtrl['sub_path'] = $this->getSubPath();
        $fileCtrl['saved_path'] = $fileCtrl['root_path'] . '/' . $fileCtrl['sub_path'];//TODO 注意路径'./',避免linux造成'./'和'/'歧义
        $fileCtrl['saved_name'] = $this->getSaveFileName();
        $fileCtrl['saved_path_name'] = $fileCtrl['saved_path'] . '/' . $fileCtrl['saved_name'] . '.' . $fileCtrl['ext'];

        //检查是否允许覆盖
        if (!$configs['replace'] && is_file($fileCtrl['saved_path_name'])) {
            abort($this->makeApiReturn(
                "保存文件重名，请重新尝试", [],
                ErrorCode::ClientError_ArgsWrong,
                HttpReponseCode::ClientError_BadRequest
            ));
        }
        //检查保存目录是否存在
        $this->mkPath($fileCtrl['saved_path']);

        //检查保存目录是否可写
        $this->checkPathWritable($fileCtrl['saved_path']);

        //保存图片并获取文件信息
        $image->save($fileCtrl['saved_path_name']);

        $fileCtrl['md5'] = md5_file($fileCtrl['saved_path_name']);
        $fileCtrl['sha1'] = sha1_file($fileCtrl['saved_path_name']);
    }

    private function saveCtrlFileToDb(&$fileCtrll)
    {
        $model = new Files();
        $data = array(
            'type' => $this->getFileType(),
            'name' => $fileCtrll['name'],
            'name_saved' => $fileCtrll['saved_name'],
            'ext' => $fileCtrll['ext'],
            'mime' => $fileCtrll['type'],
            'path' => $fileCtrll['saved_path_name'],
            'md5' => $fileCtrll['md5'],
            'sha1' => $fileCtrll['sha1']
        );
        //TODO byZim
        $res = $model->insertGetId($data);
        if (!$res) {
            abort($this->makeApiReturn(
                "保存数据库失败", [],
                ErrorCode::ServerError_DB_ERROR,
                HttpReponseCode::ServerError_InternalServer_Error
            ));
        }
        $fileCtrll['id'] = intval($res);
    }
}

