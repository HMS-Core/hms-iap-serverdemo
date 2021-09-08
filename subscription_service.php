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
require "at_demo.php";

class SubscriptionService {
    // TODO: replace the (ip:port) to the real one, and if the protocol is https, you should deal with the license yourself.
    //yourself
    const TOC_SITE_URL = "http://ip:port";
    //site fore telecom carrier
    const TOBTOC_SITE_URL = "https://subscr-at-dre.iap.dbankcloud.com";

    const GET_SUBSCRIPTION_URL = "/sub/applications/v2/purchases/get";
    const STOP_SUBSCRIPTION_URL = "/sub/applications/v2/purchases/stop";
    const DELAY_SUBSCRIPTION_URL = "/sub/applications/v2/purchases/delay";
    const RETURN_FEE_SUBSCRIPTION_URL = "/sub/applications/v2/purchases/returnFee";
    const WITHDRAWAL_SUBSCRIPTION_URL = "/sub/applications/v2/purchases/withdrawal";

    public function getRootUrl($accountFlag) {
        if ($accountFlag != null && $accountFlag == 1) {
            return self::TOBTOC_SITE_URL;
        }
        return self::TOC_SITE_URL;
    }

    public function getSubscription($subscriptionId, $purchaseToken, $accountFlag) {
        // fetch the App Level AccessToken
        $appAT = AtDemo::getAppAT();
        if ($appAT == null) {
            return;
        }
        // construct the Authorization in Header
        $headers = AtDemo::buildAuthorization($appAT);

        // pack the request body
        $body = ["subscriptionId" => $subscriptionId, "purchaseToken" => $purchaseToken];
        $msgBody = json_encode($body);

        $response = AtDemo::httpPost(self::getRootUrl($accountFlag).self::GET_SUBSCRIPTION_URL, $msgBody, 5, 5, $headers);

        // TODO: display the response as string in console, you can replace it with your business logic.
        echo $response;
    }

    public function stopSubscription($subscriptionId, $purchaseToken, $accountFlag) {
        // fetch the App Level AccessToken
        $appAT = AtDemo::getAppAT();
        if ($appAT == null) {
            return;
        }
        // construct the Authorization in Header
        $headers = AtDemo::buildAuthorization($appAT);

        // pack the request body
        $body = ["subscriptionId" => $subscriptionId, "purchaseToken" => $purchaseToken];
        $msgBody = json_encode($body);

        $response = AtDemo::httpPost(self::getRootUrl($accountFlag).self::STOP_SUBSCRIPTION_URL, $msgBody, 5, 5, $headers);

        // TODO: display the response as string in console, you can replace it with your business logic.
        echo $response;
    }

    public function delaySubscription($subscriptionId, $purchaseToken, $currentExpirationTime, $desiredExpirationTime, $accountFlag) {
        // fetch the App Level AccessToken
        $appAT = AtDemo::getAppAT();
        if ($appAT == null) {
            return;
        }
        // construct the Authorization in Header
        $headers = AtDemo::buildAuthorization($appAT);

        // pack the request body
        $body = ["subscriptionId" => $subscriptionId, "purchaseToken" => $purchaseToken, "currentExpirationTime" => $currentExpirationTime, "desiredExpirationTime" => $desiredExpirationTime];
        $msgBody = json_encode($body);

        $response = AtDemo::httpPost(self::getRootUrl($accountFlag).self::DELAY_SUBSCRIPTION_URL, $msgBody, 5, 5, $headers);

        // TODO: display the response as string in console, you can replace it with your business logic.
        echo $response;
    }

    public function returnFeeSubscription($subscriptionId, $purchaseToken, $accountFlag) {
        // fetch the App Level AccessToken
        $appAT = AtDemo::getAppAT();
        if($appAT == null){
            return;
        }
        // construct the Authorization in Header
        $headers = AtDemo::buildAuthorization($appAT);

        // pack the request body
        $body = ["subscriptionId" => $subscriptionId, "purchaseToken" => $purchaseToken];
        $msgBody = json_encode($body);

        $response = AtDemo::httpPost(self::getRootUrl($accountFlag).self::RETURN_FEE_SUBSCRIPTION_URL, $msgBody, 5, 5, $headers);

        // TODO: display the response as string in console, you can replace it with your business logic.
        echo $response;
    }

    public function withdrawSubscription($subscriptionId, $purchaseToken, $accountFlag) {
        // fetch the App Level AccessToken
        $appAT = AtDemo::getAppAT();
        if ($appAT == null) {
            return;
        }
        // construct the Authorization in Header
        $headers = AtDemo::buildAuthorization($appAT);

        // pack the request body
        $body = ["subscriptionId" => $subscriptionId, "purchaseToken" => $purchaseToken];
        $msgBody = json_encode($body);

        $response = AtDemo::httpPost(self::getRootUrl($accountFlag).self::WITHDRAWAL_SUBSCRIPTION_URL, $msgBody, 5, 5, $headers);

        // TODO: display the response as string in console, you can replace it with your business logic.
        echo $response;
    }
}