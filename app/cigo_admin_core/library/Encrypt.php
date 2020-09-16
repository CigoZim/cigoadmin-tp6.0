<?php

namespace app\cigo_admin_core\library;

use Think\Exception;

/**
 * 加密管理类
 * 1：RSA非对称加密
 * 2：AES对称加密
 *
 * Class Encrypt
 * @package app\cigo_admin_core\library
 */
class Encrypt
{
    /**
     * 初始化Rsa密钥对
     *
     * @return array|bool
     */
    public static function initRsaKey()
    {
        $config = array(
            "private_key_bits" => 2048,
            "private_key_type" => OPENSSL_KEYTYPE_RSA
        );
        $res = openssl_pkey_new($config);
        if ($res == false) return false;
        openssl_pkey_export($res, $privateKey);
        $publicKeyInfo = openssl_pkey_get_details($res);

        $privateKeyStr = preg_replace('/' . config('cigo.PRIVATE_KEY_BEGIN') . '/i', '', $privateKey);
        $privateKeyStr = preg_replace('/' . config('cigo.PRIVATE_KEY_END') . '/i', '', $privateKeyStr);

        $publicKeyStr = preg_replace('/' . config('cigo.PUBLIC_KEY_BEGIN') . '/i', '', $publicKeyInfo["key"]);
        $publicKeyStr = preg_replace('/' . config('cigo.PUBLIC_KEY_END') . '/i', '', $publicKeyStr);

        return array(
            'rsaPrivateKey' => trim(str_replace("\n", "", $privateKeyStr)),
            'rsaPublicKey' => trim(str_replace("\n", "", $publicKeyStr))
        );
    }

    /**
     * rsa使用公钥进行加密
     *
     * @param $rsaPublicKey
     * @param $plainStr
     * @param $encryptedStr
     */
    public static function rsaEncryptByPublicKey($rsaPublicKey, $plainStr, &$encryptedStr)
    {

        $publicKey = config('cigo.PUBLIC_KEY_BEGIN') . trim($rsaPublicKey) . config('cigo.PUBLIC_KEY_END');
        $keyResId = openssl_pkey_get_public($publicKey);

        openssl_public_encrypt(trim($plainStr), $encryptedStr, $keyResId);

        $encryptedStr = base64_encode($encryptedStr);
        $encryptedStr = trim(urlencode($encryptedStr));
    }

    /**
     * rsa使用私钥进行解密
     *
     * @param $rsaPrivateKey
     * @param $encryptedStr
     * @param $plainStr
     */
    public static function rsaDecryptByPrivateKey($rsaPrivateKey, $encryptedStr, &$plainStr)
    {
        $private_key = config('cigo.PRIVATE_KEY_BEGIN') . trim($rsaPrivateKey) . config('cigo.PRIVATE_KEY_END');
        $keyResId = openssl_pkey_get_private($private_key);

        $encryptedStr = urldecode(trim($encryptedStr));
        $encryptedStr = base64_decode($encryptedStr);

        openssl_private_decrypt($encryptedStr, $plainStr, $keyResId)
            ? false
            : $plainStr = '';
    }

    /**
     * rsa使用私钥进行加密
     *
     * @param $rsaPrivateKey
     * @param $plainStr
     * @param $encryptedStr
     */
    public static function rsaEncryptByPrivateKey($rsaPrivateKey, $plainStr, &$encryptedStr)
    {
        $private_key = config('cigo.PRIVATE_KEY_BEGIN') . trim($rsaPrivateKey) . config('cigo.PUBLIC_KEY_BEGIN');
        $keyResId = openssl_pkey_get_private($private_key);

        openssl_private_encrypt(trim($plainStr), $encryptedStr, $keyResId);

        $encryptedStr = base64_encode($encryptedStr);
        $encryptedStr = trim(urlencode($encryptedStr));
    }

    /**
     * rsa使用公钥进行解密
     *
     * @param $rsaPublicKey
     * @param $encryptedStr
     * @param $plainStr
     */
    public static function rsaDecryptByPublicKey($rsaPublicKey, $encryptedStr, &$plainStr)
    {
        $publicKey = config('cigo.PUBLIC_KEY_BEGIN') . trim($rsaPublicKey) . config('cigo.PUBLIC_KEY_END');
        $keyResId = openssl_pkey_get_public($publicKey);

        $encryptedStr = urldecode(trim($encryptedStr));
        $encryptedStr = base64_decode($encryptedStr);

        openssl_public_decrypt($encryptedStr, $plainStr, $keyResId)
            ? false
            : $plainStr = '';
    }

    /**
     * 获取指定长度随机字符串
     *
     * @param int $length
     * @return string
     * @throws Exception
     */
    public static function getRandomString($length = 32)
    {
        if (function_exists('openssl_random_pseudo_bytes')) {
            $bytes = openssl_random_pseudo_bytes($length);

            if ($bytes === false)
                throw new Exception('Unable to generate a random string');

            return trim(substr(str_replace(['/', '+', '='], '', base64_encode($bytes)), 0, $length));
        }

        $pool = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        return trim(substr(str_shuffle(str_repeat($pool, 5)), 0, $length));
    }

    /**
     * 获取指定长度token
     *
     * @param int $len
     * @return string
     * @throws Exception
     */
    public static function makeToken($len = 32)
    {
        $hashStr = hash('sha256', Encrypt::getRandomString($len * 2), false);
        return trim(substr($hashStr, 0, $len));
    }

    /**
     * 初始化aes密钥
     *
     * @return string
     * @throws Exception
     */
    public static function initAesKey()
    {
        return Encrypt::makeToken(config('cigo.AES_KEY_LEN'));
    }

    /**
     * aes加密
     *
     * @param $plainStr
     * @param $key
     * @return string
     */
    public static function aesEncrypt($plainStr, $key)
    {
        $encryptString = openssl_encrypt(trim($plainStr), config('cigo.AES_METHODS'), $key, false);
        return trim(urlencode($encryptString));
    }

    /**
     * aes解密
     *
     * @param $encryptedStr
     * @param $key
     * @return string
     */
    public static function aesDescrypt($encryptedStr, $key)
    {
        $encryptedStr = urldecode(trim($encryptedStr));
        return openssl_decrypt($encryptedStr, config('cigo.AES_METHODS'), $key, false);
    }

    /**
     * 加密函数
     * @param string $src 明文
     * @return string 加密后的密文
     */
    public static function encrypt($src)
    {
        return base64_encode(hash('sha256', $src, false));
    }
}