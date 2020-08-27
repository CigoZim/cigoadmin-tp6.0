<?php
//TODO by zim
return [
    /* 文件上传相关配置 */
    'FILE_UPLOAD' => array(
        'autoSub' => true, //自动子目录保存文件
        'subName' => array('date', 'Y-m-d'), //子目录创建方式，[0]-函数名，[1]-参数，多个参数使用数组
        'rootPath' => './upload/images', //保存根路径
        'waterImg' => './upload/water.jpg',//图片水印图片路径
        'waterText' => '我是水印',//文字水印
        'waterTextFont' => './upload/msyh.ttf',//文字水印字体路径
        'replace' => false, //存在同名是否覆盖
        'fileLimit' => array(
            'img' => array(
                'maxSize' => 20 * 1024 * 1024,
                'exts' => 'jpg,gif,png,jpeg',
            ),
            'video' => array(
                'maxSize' => 300 * 1024 * 1024,
                'exts' => 'mp4,rmvb,mov'
            ),
            'file' => array(
                'maxSize' => 100 * 1024 * 1024,
                'exts' => 'doc,docx,xls,xlsx,ppt,pptx,zip,rar,txt,apk'
            )
        ),
    ), //文件上传相关配置（文件上传类配置）
];
