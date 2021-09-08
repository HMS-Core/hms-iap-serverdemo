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

package com.huawei.iap.demo;

import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * 功能描述
 *
 * @author iap
 * @since 2019-12-27
 */
public class SubscriptionService {
    // TODO: replace the (ip:port) to the real one, and if the protocol is https, you should deal with the license
    // yourself.
    public static final String TOC_SITE_URL = "http://ip:port";

    // site for telecom carrier
    public static final String TOBTOC_SITE_URL = "https://subscr-at-dre.iap.dbankcloud.com";

    public static String getRootUrl(Integer accountFlag) {
        if (accountFlag != null && accountFlag == 1) {
            return TOBTOC_SITE_URL;
        }
        return TOC_SITE_URL;
    }

    public static void getSubscription(String subscriptionId, String purchaseToken, Integer accountFlag)
        throws Exception {
        // fetch the App Level AccessToken
        String appAt = AtDemo.getAppAT();
        // construct the Authorization in Header
        Map<String, String> headers = AtDemo.buildAuthorization(appAt);

        // pack the request body
        Map<String, String> bodyMap = new HashMap<>();
        bodyMap.put("subscriptionId", subscriptionId);
        bodyMap.put("purchaseToken", purchaseToken);

        String msgBody = JSONObject.toJSONString(bodyMap);

        String response = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/get",
            "application/json; charset=UTF-8", msgBody, 5000, 5000, headers);
        // TODO: display the response as string in console, you can replace it with your business logic.
        System.out.println(response);
    }

    public static void stopSubscription(String subscriptionId, String purchaseToken, Integer accountFlag)
        throws Exception {
        // fetch the App Level AccessToken
        String appAt = AtDemo.getAppAT();
        // construct the Authorization in Header
        Map<String, String> headers = AtDemo.buildAuthorization(appAt);

        // pack the request body
        Map<String, String> bodyMap = new HashMap<>();
        bodyMap.put("subscriptionId", subscriptionId);
        bodyMap.put("purchaseToken", purchaseToken);

        String msgBody = JSONObject.toJSONString(bodyMap);

        String response = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/stop",
            "application/json; charset=UTF-8", msgBody, 5000, 5000, headers);
        // TODO: display the response as string in console, you can replace it with your business logic.
        System.out.println(response);
    }

    public static void delaySubscription(String subscriptionId, String purchaseToken, Long currentExpirationTime,
        Long desiredExpirationTime, Integer accountFlag) throws Exception {
        // fetch the App Level AccessToken
        String appAt = AtDemo.getAppAT();
        // construct the Authorization in Header
        Map<String, String> headers = AtDemo.buildAuthorization(appAt);

        // pack the request body
        Map<String, Object> bodyMap = new HashMap<>();
        bodyMap.put("subscriptionId", subscriptionId);
        bodyMap.put("purchaseToken", purchaseToken);
        bodyMap.put("currentExpirationTime", currentExpirationTime);
        bodyMap.put("desiredExpirationTime", desiredExpirationTime);

        String msgBody = JSONObject.toJSONString(bodyMap);

        String response = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/delay",
            "application/json; charset=UTF-8", msgBody, 5000, 5000, headers);
        // TODO: display the response as string in console, you can replace it with your business logic.
        System.out.println(response);
    }

    public static void returnFeeSubscription(String subscriptionId, String purchaseToken, Integer accountFlag)
        throws Exception {
        // fetch the App Level AccessToken
        String appAt = AtDemo.getAppAT();
        // construct the Authorization in Header
        Map<String, String> headers = AtDemo.buildAuthorization(appAt);

        // pack the request body
        Map<String, String> bodyMap = new HashMap<>();
        bodyMap.put("subscriptionId", subscriptionId);
        bodyMap.put("purchaseToken", purchaseToken);

        String msgBody = JSONObject.toJSONString(bodyMap);

        String response = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/returnFee",
            "application/json; charset=UTF-8", msgBody, 5000, 5000, headers);
        // TODO: display the response as string in console, you can replace it with your business logic.
        System.out.println(response);
    }

    public static void withdrawSubscription(String subscriptionId, String purchaseToken, Integer accountFlag)
        throws Exception {
        // fetch the App Level AccessToken
        String appAt = AtDemo.getAppAT();
        // construct the Authorization in Header
        Map<String, String> headers = AtDemo.buildAuthorization(appAt);

        // pack the request body
        Map<String, String> bodyMap = new HashMap<>();
        bodyMap.put("subscriptionId", subscriptionId);
        bodyMap.put("purchaseToken", purchaseToken);

        String msgBody = JSONObject.toJSONString(bodyMap);

        String response = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/withdrawal",
            "application/json; charset=UTF-8", msgBody, 5000, 5000, headers);
        // TODO: display the response as string in console, you can replace it with your business logic.
        System.out.println(response);
    }

}
