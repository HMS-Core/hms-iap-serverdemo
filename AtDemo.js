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

const request = require('request');
const querystring = require('querystring');

const client_secret = 'appsecret';   // your client secret
const client_id = '1234567';         // your app id
var tokenUrl = 'https://oauth-login.cloud.huawei.com/oauth2/v3/token'; //token url to get the authorization

const grant_type = 'client_credentials';
const atOption={
    url: tokenUrl,
    form: {
        grant_type: grant_type,
        client_id: client_id,
        client_secret: querystring.escape(client_secret)
    }
};

// The accessToken.
var accessToken = '';

/**
 * Get App Level AccessToken and execute the request.
 *
 * @param url           the request url
 * @param requestData   the request data
 * @param callback      the callback of response
 */
var getAppAtAndExecuteRequest = function (url, requestData, callback) {
    request.post(atOption, (error, response, body) => {
        if (!error && response.statusCode == 200) {
            let result = JSON.parse(body);
            accessToken = result.access_token;

            // set the requestOption
            requestOption.url = url;
            requestOption.body = requestData;

            // construct the Authorization in Header
            let oriString = 'APPAT:'+accessToken;
            let authorization = new Buffer.from(oriString).toString('base64');
            requestOption.headers.Authorization = 'Basic '+ authorization;

            httpPost(requestOption, callback);
        } else {
            if (error) {
                console.error(error);
            }
            if (body) {
                console.error('Get AccessToken error: ' + body)
            }
            accessToken = null;
        }
    });
};


// the request option
var requestOption = {
    method: "POST",
    json: true,
    headers: {
        "content-type": "application/json"
    }
};

/**
 * Http post function.
 *
 * @param option    the request option
 * @param callback  the callback of response
 */
const httpPost = function (option, callback) {
    request.post({
        ...option,
        ciphers: 'TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256',
        minVersion: 'TLSv1.2',
    }, function (error, response, body) {
        if (!error && response.statusCode == 200) {
            callback(error, body);
        }
    });
};


// export function
exports.getAppAtAndExecuteRequest = getAppAtAndExecuteRequest;
exports.httpPost = httpPost;
