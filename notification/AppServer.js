/*
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

const NodeRSA = require('node-rsa');

// !!! the public key
const public_key = 'the public key';
// the notificationType
const NOTIFICATION_TYPE = {
    INITIAL_BUY: 0,
    CANCEL: 1,
    RENEWAL: 2,
    INTERACTIVE_RENEWAL: 3,
    NEW_RENEWAL_PREF: 4,
    RENEWAL_STOPPED: 5,
    RENEWAL_RESTORED: 6,
    RENEWAL_RECURRING: 7,
    ON_HOLD: 9,
    PAUSED: 10,
    PAUSE_PLAN_CHANGED: 11,
    PRICE_CHANGE_CONFIRMED: 12,
    DEFERRED: 13
};

/**
 * deal notification information
 *
 * @param information the notification information
 */
var dealNotification = function (information) {
    if (information == null || information.length == 0) {
        return;
    }

    var statusUpdateNotificationRequest = JSON.parse(information);
    var response = {};

    var content = statusUpdateNotificationRequest.statusUpdateNotification;
    var sign = statusUpdateNotificationRequest.notifycationSignature;
    if (sign == null || content == null) {
        // failure, the response set by yourself
        response.errorCode = '1';
        response.errorMsg = 'the notification message is empty';
        return;
    }

    const key = new NodeRSA({b: 3096});
    key.importKey(public_key, "pkcs8-public-pem");
    // check sign
    var isCheckOk = key.verify(content, sign, 'utf-8', "base64");
    console.log("Checking sign result is ：" + isCheckOk);
    if (!isCheckOk) {
        // failure, the response set by yourself
        response.errorCode = '2';
        response.errorMsg = 'Verify the sign failure';
        return;
    }

    // TODO replace with your logic
    var statusUpdateNotification = JSON.parse(content);
    var notificationType = statusUpdateNotification.notificationType;
    console.log(statusUpdateNotification);
    switch (notificationType) {
        case NOTIFICATION_TYPE.INITIAL_BUY:
            break;
        case NOTIFICATION_TYPE.CANCEL:
            console.log("123");
            break;
        case NOTIFICATION_TYPE.RENEWAL:
            break;
        case NOTIFICATION_TYPE.INTERACTIVE_RENEWAL:
            break;
        case NOTIFICATION_TYPE.NEW_RENEWAL_PREF:
            break;
        case NOTIFICATION_TYPE.RENEWAL_STOPPED:
            break;
        case NOTIFICATION_TYPE.RENEWAL_RESTORED:
            break;
        case NOTIFICATION_TYPE.RENEWAL_RECURRING:
            break;
        case NOTIFICATION_TYPE.ON_HOLD:
            break;
        case NOTIFICATION_TYPE.PAUSED:
            break;
        case NOTIFICATION_TYPE.PAUSE_PLAN_CHANGED:
            break;
        case NOTIFICATION_TYPE.PRICE_CHANGE_CONFIRMED:
            break;
        case NOTIFICATION_TYPE.DEFERRED:
            break;
        default:
            break;
    }
};


const infor = ' {\n' +
    '"statusUpdateNotification":"{\\"environment\\":\\"hehe\\",\\"notificationType\\":1,\\"subscriptionId\\":\\"subscriptionId\\",\\"cancellationDate\\":2020330000,\\"orderId\\":\\"hehe\\",\\"latestReceiptInfo\\":\\"latestReceiptInfo\\",\\"latestReceiptInfoSignature\\":\\"latestExpiredReceipt\\",\\"latestExpiredReceipt\\":\\"latestExpiredReceipt\\",\\"latestExpiredReceiptInfo\\":\\"sssdewwewef\\",\\"latestExpiredReceiptInfoSignature\\":\\"ssdasdasdfsdf\\",\\"autoRenewStatus\\":1,\\"refundPayOrderId\\":\\"refund\\",\\"productId\\":\\"dsdsdss\\",\\"expirationIntent\\":1}", \n' +
    '"notifycationSignature":"hDj6HxVxUeMgWYzy/E5X4qXjm/1vBWmdsW3EsMb2vvjyOqjDUDZxzQsTbOgGk5gLZ/A1kp6KRwywrvuCqN7Yzu10VDkpAL3PuB/wsnLbOVxJT3Ou9ipE/J0HaoDKN7TnCuIqw1R1209UbIO8crldTH00fR6GioUWOvQSN192bY6S1JAPdKf62GoUZgrHJuRpvk0W90SEKIEbMgg+Ekb/MqTgmYE9j0U8ujCH6e/hPLs6hRUbv4xal68ERZy7L8koj+s0EVn3MUP63qL1D81vbHpclzOfqdBQetGFCiy/JziBlc+vgVcdwPBNxdLSHnjmz1VOX/l9qr1t8FwBA1QLZA=="\n' +
    '}';
dealNotification(infor);
