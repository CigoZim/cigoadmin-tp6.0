<?php

namespace app\cigo_admin_core\library\utils;

use think\facade\Request;

class  ClientTye
{
    const TYPE_WX = 'weixin';
    const TYPE_ANDROID = 'android';
    const TYPE_IPHONE = 'iphone';
    const TYPE_MAC = 'mac';
    const TYPE_WIN = 'windows';
    const TYPE_UNBUNTU = 'ubuntu';
    const TYPE_OTHER = 'other';

    static function getClientType()
    {
        $clientAgent = strtolower(Request::header('USER_AGENT'));

        if (strpos($clientAgent, "micromessenger") !== false) {
            return self::TYPE_WX;
        }

        if (strpos($clientAgent, "android") !== false) {
            return self::TYPE_ANDROID;
        }

        if (strpos($clientAgent, "iphone") !== false) {
            return self::TYPE_IPHONE;
        }

        if (strpos($clientAgent, "windows") !== false) {
            return self::TYPE_WIN;
        }
        if (strpos($clientAgent, "mac") !== false) {
            return self::TYPE_MAC;
        }
        if (strpos($clientAgent, "ubuntu") !== false) {
            return self::TYPE_UNBUNTU;
        }

        return self::TYPE_OTHER;
    }
}
