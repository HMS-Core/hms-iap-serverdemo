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

const AtDemo = require('./AtDemo');

// TODO: replace the (ip:port) to the real one, and if the protocol is https, you should deal with the license yourself.
const TOC_SITE_URL = 'http://ip:port';

// the request url
const tokenVerifyUrl = '/applications/purchases/tokens/verify';
// the request body, values of the request body should be replaced with the actual one.
const tokenVerifyRequest = {
    purchaseToken: '1111111111.1.11111',
    productId: '11111',
};

/*
 * the callback of verifyToken
 *
 * @param errorMsg  the errorMsg
 * @param response  the response
 */
var verifyTokenCallback = function (errorMsg, response) {
    if (errorMsg) {
        console.log(errorMsg);
    }
    if (response) {
        console.log(response);
        // TODO: display the response data in console, you can replace it with your business logic.
    }
};

// execute the tokenVerifyRequest
var verifyToken = function () {
    AtDemo.getAppAtAndExecuteRequest(TOC_SITE_URL + tokenVerifyUrl, tokenVerifyRequest, verifyTokenCallback);
};


// the request url
const cancelledPurchaseUrl = '/applications/v2/purchases/cancelledList';
// the request body, values of the request body should be replaced with the actual one.
const cancelledPurchaseRequest = {
    endAt: 1574068040390,
    startAt: 1573463240390,
    maxRows: 3,
    continuationToken: "",
    type: 0
};

/*
 * the callback of cancelledListPurchase
 *
 * @param errorMsg  the errorMsg
 * @param response  the response
 */
var cancelledListPurchaseCallback = function (errorMsg, response) {
    if (errorMsg) {
        console.log(errorMsg);
    }
    if (response) {
        console.log(response);
        // TODO: display the response data in console, you can replace it with your business logic.
    }
};

// execute the cancelledPurchaseRequest
var cancelledListPurchase = function () {
    AtDemo.getAppAtAndExecuteRequest(TOC_SITE_URL + cancelledPurchaseUrl, cancelledPurchaseRequest, cancelledListPurchaseCallback);
};

// the request url
const confirmPurchaseUrl = '/applications/v2/purchases/confirm';
// the request body, values of the request body should be replaced with the actual one.
const confirmPurchaseRequest = {
    purchaseToken: '1111111111.1.11111',
    productId: '11111',
};
/*
 * the callback of confirmPurchase
 *
 * @param errorMsg  the errorMsg
 * @param response  the response
 */
var confirmPurchaseCallback = function (errorMsg, response) {
    if (errorMsg) {
        console.log(errorMsg);
    }
    if (response) {
        console.log(response);
        // TODO: display the response data in console, you can replace it with your business logic.
    }
};

// execute the confirmPurchase
var confirmPurchase = function () {
    AtDemo.getAppAtAndExecuteRequest(TOC_SITE_URL + confirmPurchaseUrl, confirmPurchaseRequest, confirmPurchaseCallback);
};

verifyToken(0);
cancelledListPurchase(0);
confirmPurchase(0);
