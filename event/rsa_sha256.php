<?php
/**
 * Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 *
 */

class RSA{
    public static function generatePubKey($publicKey) {
        $begin_public = "-----BEGIN PUBLIC KEY-----\n";
        $end_public = "-----END PUBLIC KEY-----\n";
        $pubKey = $begin_public.chunk_split($publicKey, 64, "\n").$end_public;
        return $pubKey;
    }

    public static function generatePriKey($privateKey){
        $begin_private = "-----BEGIN RSA PRIVATE KEY-----\n";
        $end_private = "-----END RSA PRIVATE KEY-----\n";
        $priKey = $begin_private.chunk_split($privateKey, 64, "\n").$end_private;
        return $priKey;
    }

    //sign
    public static function sign($content,$privateKey){
        $priKey = openssl_get_privatekey(RSA::generatePriKey($privateKey));
        openssl_sign($content, $sign, $priKey,OPENSSL_ALGO_SHA256);
        openssl_free_key($priKey);
        $sign = base64_encode($sign);
        return $sign;
    }

    //verify
    public static function doCheck($content, $sign, $publicKey){
        if($sign == null){
            return false;
        }
        if($publicKey == null){
            return false;
        }
        try{
            $pubKey = openssl_get_publickey(RSA::generatePubKey($publicKey));
            $result = openssl_verify($content,base64_decode($sign),$pubKey,OPENSSL_ALGO_SHA256);
            openssl_free_key($pubKey);
            return $result;
        }catch (Exception $e){
            $e->getMessage();
            return false;
        }
    }
}