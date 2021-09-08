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
require "rsa_sha256.php";

header("Content-Type: application/json; charset=utf-8");
$raw_post_data = file_get_contents('php://input');
$server = new AppServer();
$server->deal_notification($raw_post_data);

class AppServer{
    var $publicKey = "publicKey"; //your app's public Key
    function deal_notification($raw_post_data){
        $request = json_decode($raw_post_data,false);
        $response = new StatusUpdateNotificationResponse();
        if(empty( $request->statusUpdateNotification)|| empty($request->notifycationSignature))
        {
            $response->errorCode = 1; //failure
            $response->errorMsg = "the notification message is empty";
            echo $response->buildResponse();
            return;
        }
        // verify the notification
        $ok=RSA::doCheck($request->statusUpdateNotification,$request->notifycationSignature,$this->publicKey);
        if(!$ok) {
            $response->errorCode = 2; //failure
            $response->errorMsg = "verify the sign failure";
            echo $response->buildResponse();
            return;
        }

        $statusUpdateNotification = json_decode($request->statusUpdateNotification,false);

        //TODO replace with your logic
        switch ($statusUpdateNotification->notificationType) {
            case NOTIFICATION_TYPE::INITIAL_BUY:
                break;
            case NOTIFICATION_TYPE::CANCEL:
                break;
            case NOTIFICATION_TYPE::RENEWAL:
                break;
            case NOTIFICATION_TYPE::INTERACTIVE_RENEWAL:
                break;
            case  NOTIFICATION_TYPE::NEW_RENEWAL_PREF:
                break;
            case NOTIFICATION_TYPE::RENEWAL_STOPPED:
                break;
            case  NOTIFICATION_TYPE::RENEWAL_RESTORED:
                break;
            case  NOTIFICATION_TYPE::RENEWAL_RECURRING:
                break;
            case  NOTIFICATION_TYPE::ON_HOLD:
                break;
            case  NOTIFICATION_TYPE::PAUSED:
                break;
            case  NOTIFICATION_TYPE::PAUSE_PLAN_CHANGED:
                break;
            case  NOTIFICATION_TYPE::PRICE_CHANGE_CONFIRMED:
                break;
            case  NOTIFICATION_TYPE::DEFERRED:
                break;
        }
    }
}

interface NOTIFICATION_TYPE {
    const INITIAL_BUY = 0;
    const CANCEL = 1;
    const RENEWAL = 2;
    const INTERACTIVE_RENEWAL = 3;
    const NEW_RENEWAL_PREF = 4;
    const RENEWAL_STOPPED =5;
    const RENEWAL_RESTORED = 6;
    const RENEWAL_RECURRING = 7;
    const ON_HOLD = 9;
    const PAUSED = 10;
    const PAUSE_PLAN_CHANGED = 11;
    const PRICE_CHANGE_CONFIRMED = 12;
    const DEFERRED = 13;
}

class StatusUpdateNotificationResponse {
    var $errorCode;
    var $errorMsg;
    function buildResponse(){
        return "{\"errorCode\":$this->errorCode,\"errorMsg\":\"$this->errorMsg\"}";
    }
}

class StatusUpdateNotificationRequest{
    var $statusUpdateNotification;
    var $notifycationSignature;
}

class StatusUpdateNotification{
    var $environment;
    var $notificationType;
    var $subscriptionId;
    var $cancellationDate;
    var $orderId;
    var $latestReceipt;
    var $latestReceiptInfo;
    var $latestReceiptInfoSignature;
    var $latestExpiredReceipt;
    var $latestExpiredReceiptInfo;
    var $latestExpiredReceiptInfoSignature;
    var $autoRenewStatus;
    var $refundPayOrderId;
    var $productId;
    var $expirationIntent;
}


