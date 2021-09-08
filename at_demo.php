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
class AtDemo {
    const CLIENT_SECRET = "secret"; // your app secret
    const CLIENT_ID = "123456"; //your appId
    const TOKEN_URL = "https://oauth-login.cloud.huawei.com/oauth2/v3/token"; //token url to get the authorization
    private static  $accessToken = null;

    /**
     * Gets App Level AccessToken.
     *
     * @return string the App Level AccessToken
     */
    public static function getAppAT() {
        if(self::$accessToken != null && self::$accessToken != ''){
            return self::$accessToken;
        }
        $grant_type = "client_credentials";
        $dataArray= array("grant_type"=>$grant_type,"client_id"=>AtDemo::CLIENT_ID,"client_secret"=>AtDemo::CLIENT_SECRET);
        $data=http_build_query($dataArray, '', '&');
        $header = array("Content-Type: application/x-www-form-urlencoded; charset=UTF-8");
        try{
            $ret = self::doPost(AtDemo::TOKEN_URL, $data,  5,5,$header);
            $result = $ret[0];
            $status_code = $ret[1];
            if($status_code != '200'){
                echo "get token error! the oauth server response=",$result;
                return null;
            }
            $array = json_decode($result,true);
            self::$accessToken = $array["access_token"];
        } catch (Exception $e){
            echo $e->getMessage();
        }
        // TODO: display the accessToken, you can remove it
        echo  self::$accessToken;
        return  self::$accessToken;
    }

    /**
     * Http post function. when the AppAT is out of time, get AppAT and try again.
     *
     * @param $httpUrl string the http url
     * @param $data string the data
     * @param $connectTimeout int the connect timeout
     * @param $readTimeout int the read timeout
     * @param $headers array the headers
     * @return string the result
     */
    public static function  httpPost($httpUrl, $data, $connectTimeout, $readTimeout,$headers) {
        $ret = self::doPost($httpUrl, $data, $connectTimeout, $readTimeout,$headers);
        $result = $ret[0];
        $status_code = $ret[1];
        //when statusCode is 401, means AT is expired
        if($status_code == '401'){
            //refresh Access Token
            self::$accessToken = '';
            $appAt =self::getAppAT();
            $headers = self::buildAuthorization($appAt);
            $ret = self::doPost($httpUrl, $data, $connectTimeout, $readTimeout,$headers);
            $result = $ret[0];
        }
        return $result;
    }

    /**
     * Http post function.
     *
     * @param $httpUrl string the http url
     * @param $data string the data
     * @param $connectTimeout int the connect timeout
     * @param $readTimeout int the read timeout
     * @param $headers array the headers
     * @return array the result and status code
     */
    private static function doPost($httpUrl, $data, $connectTimeout, $readTimeout,$headers) {
        $options = array(
            CURLOPT_POST => 1,
            CURLOPT_URL => $httpUrl,
            CURLOPT_HTTPHEADER => $headers,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_CONNECTTIMEOUT => $connectTimeout,
            CURLOPT_TIMEOUT => $readTimeout,
            CURLOPT_POSTFIELDS => $data,
            CURLOPT_SSL_VERIFYPEER => 0 //disable HTTPS protocol to verify SSL security certificate
        );
        $ch = curl_init();
        curl_setopt_array($ch, $options);
        $result = curl_exec($ch);
        $status_code = curl_getinfo($ch,CURLINFO_HTTP_CODE);
        if (curl_error($ch)) {
            var_dump($ch);
            $result = false;
        }
        curl_close($ch);
        return [$result,$status_code];
    }

    /**
     * build IAP Authorization
     *
     * @param $appAT string the AppAT
     * @return array the header
     */
    public static function buildAuthorization($appAT) {
        $oriString = "APPAT:".$appAT;
        $authHead = "Basic ".base64_encode(utf8_encode($oriString))."";
        $headers = ["Authorization:".$authHead,"Content-Type: application/json; charset=UTF-8"];
        return $headers;
    }
}