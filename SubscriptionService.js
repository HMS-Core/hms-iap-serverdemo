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
const getSubscriptionUrl = '/sub/applications/v2/purchases/get';
// the request body, values of the request body should be replaced with the actual one.
const getSubscriptionRequest = {
    purchaseToken: '1111111111.1.11111',
    subscriptionId: '11111',
};

/*
 * the callback of getSubscription
 *
 * @param errorMsg  the errorMsg
 * @param response  the response
 */
var getSubscriptionCallback = function (errorMsg, response) {
    if (errorMsg) {
        console.log(errorMsg);
    }
    if (response) {
        console.log(response);
        // TODO: display the response data in console, you can replace it with your business logic.
    }
};

// execute the getSubscriptionRequest
var getSubscription = function () {
    AtDemo.getAppAtAndExecuteRequest(TOC_SITE_URL + getSubscriptionUrl, getSubscriptionRequest, getSubscriptionCallback);
};


// the request url
const stopSubscriptionUrl = '/sub/applications/v2/purchases/stop';
// the request body, values of the request body should be replaced with the actual one.
const stopSubscriptionRequest = {
    purchaseToken: '1111111111.1.11111',
    subscriptionId: '11111',
};

/*
 * the callback of stopSubscription
 *
 * @param errorMsg  the errorMsg
 * @param response  the response
 */
var stopSubscriptionCallback = function (errorMsg, response) {
    if (errorMsg) {
        console.log(errorMsg);
    }
    if (response) {
        console.log(response);
        // TODO: display the response data in console, you can replace it with your business logic.
    }
};

// execute the stopSubscriptionRequest
var stopSubscription = function () {
    AtDemo.getAppAtAndExecuteRequest(TOC_SITE_URL + stopSubscriptionUrl, stopSubscriptionRequest, stopSubscriptionCallback);
};


// the request url
const delaySubscriptionUrl =  '/sub/applications/v2/purchases/delay';
// the request body, values of the request body should be replaced with the actual one.
const delaySubscriptionRequest = {
    purchaseToken: '1111111111.1.11111',
    subscriptionId: '11111',
    currentExpirationTime: 1573195398820,
    desiredExpirationTime: 1573195398830
};

/*
 * the callback of delaySubscription
 *
 * @param errorMsg  the errorMsg
 * @param response  the response
 */
var delaySubscriptionCallback = function (errorMsg, response) {
    if (errorMsg) {
        console.log(errorMsg);
    }
    if (response) {
        console.log(response);
        // TODO: display the response data in console, you can replace it with your business logic.
    }
};

// execute the delaySubscriptionRequest
var delaySubscription = function () {
    AtDemo.getAppAtAndExecuteRequest(TOC_SITE_URL + delaySubscriptionUrl, delaySubscriptionRequest, delaySubscriptionCallback);
};


// the request url
const returnFeeSubscriptionUrl = '/sub/applications/v2/purchases/returnFee';
// the request body, values of the request body should be replaced with the actual one.
const returnFeeSubscriptionRequest = {
    purchaseToken: '1111111111.1.11111',
    subscriptionId: '11111',
};

/*
 * the callback of returnFeeSubscription
 *
 * @param errorMsg  the errorMsg
 * @param response  the response
 */
var returnFeeSubscriptionCallback = function (errorMsg, response) {
    if (errorMsg) {
        console.log(errorMsg);
    }
    if (response) {
        console.log(response);
        // TODO: display the response data in console, you can replace it with your business logic.
    }
};

// execute the returnFeeSubscriptionRequest
var returnFeeSubscription = function () {
    AtDemo.getAppAtAndExecuteRequest(TOC_SITE_URL + returnFeeSubscriptionUrl, returnFeeSubscriptionRequest, returnFeeSubscriptionCallback);
};

// the request url
const withdrawalSubscriptionUrl = '/sub/applications/v2/purchases/withdrawal';
// the request body, values of the request body should be replaced with the actual one.
const withdrawalSubscriptionRequest = {
    purchaseToken: '1111111111.1.11111',
    subscriptionId: '11111',
};

/*
 * the callback of withdrawalSubscription
 *
 * @param errorMsg  the errorMsg
 * @param response  the response
 */
var withdrawalSubscriptionCallback = function (errorMsg, response) {
    if (errorMsg) {
        console.log(errorMsg);
    }
    if (response) {
        console.log(response);
        // TODO: display the response data in console, you can replace it with your business logic.
    }
};

// execute the withdrawalSubscriptionRequest
var withdrawalSubscription = function () {
    AtDemo.getAppAtAndExecuteRequest(TOC_SITE_URL + withdrawalSubscriptionUrl, withdrawalSubscriptionRequest, withdrawalSubscriptionCallback);
};

getSubscription(0);
stopSubscription(0);
delaySubscription(0);
returnFeeSubscription(0);
withdrawalSubscription(0);
