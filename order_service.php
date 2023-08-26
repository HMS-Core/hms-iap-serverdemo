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

class OrderService {
    // TODO: replace the (ip:port) to the real one, and if the protocol is https, you should deal with the license yourself.
    //yourself
    const TOC_SITE_URL = "https://ip:port";

    const VERIFY_TOKEN_URL = "/applications/purchases/tokens/verify";
    const CANCELLED_LIST_PURCHASE_URL = "/applications/v2/purchases/cancelledList";
    const CONFIRM_PURCHASE_URL = "/applications/v2/purchases/confirm";

    public function verifyToken($purchaseToken, $productId) {
        // fetch the App Level AccessToken
        $appAT = AtDemo::getAppAT();
        if ($appAT == null) {
            return;
        }
        // construct the Authorization in Header
        $headers = AtDemo::buildAuthorization($appAT);

        // pack the request body
        $body = ["purchaseToken" => $purchaseToken, "productId" => $productId];
        $msgBody = json_encode($body);

         $response = AtDemo::httpPost(self::TOC_SITE_URL.self::VERIFY_TOKEN_URL, $msgBody, 5, 5, $headers, true);

        // TODO: display the response as string in console, you can replace it with your business logic.
        echo $response;
    }

    public function cancelledListPurchase($endTime, $startTime, $maxRows, $type, $continuationToken) {
        // fetch the App Level AccessToken
        $appAT = AtDemo::getAppAT();
        if ($appAT == null) {
            return;
        }
        // construct the Authorization in Header
        $headers = AtDemo::buildAuthorization($appAT);

        // pack the request body
        $body = ["endAt" => $endTime, "startAt" => $startTime, "maxRows" => $maxRows, "type" => $type, "continuationToken" => $continuationToken];
        $msgBody = json_encode($body);

         $response = AtDemo::httpPost(self::TOC_SITE_URL.self::CANCELLED_LIST_PURCHASE_URL, $msgBody, 5, 5, $headers, true);

        // TODO: display the response as string in console, you can replace it with your business logic.
        echo $response;
    }

    public function confirmPurchase($purchaseToken, $productId) {
        // fetch the App Level AccessToken
        $appAT = AtDemo::getAppAT();
        if($appAT == null){
            return;
        }
        // construct the Authorization in Header
        $headers = AtDemo::buildAuthorization($appAT);

        // pack the request body
        $body = ["purchaseToken"=>$purchaseToken,"productId"=>$productId];
        $msgBody = json_encode($body);

        $response = AtDemo::httpPost(self::TOC_SITE_URL.self::CONFIRM_PURCHASE_URL, $msgBody, 5, 5, $headers, true);

        // TODO: display the response as string in console, you can replace it with your business logic.
        echo $response;
    }
}
