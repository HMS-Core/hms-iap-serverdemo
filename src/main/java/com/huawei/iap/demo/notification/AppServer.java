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

package com.huawei.iap.demo.notification;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;

import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.spec.X509EncodedKeySpec;

/**
 * 功能描述
 *
 * @author iap
 * @since 2020-02-05
 */
public class AppServer {
    // the public key
    private static final String PUBLIC_KEY = "the public key";

    private static final ObjectMapper MAPPER = new ObjectMapper();

    /**
     * deal notification information
     *
     * @param information the notification information
     */
    public void dealNotification(String information) throws Exception {
        if (StringUtils.isEmpty(information)) {
            return;
        }
        StatusUpdateNotificationRequest request = MAPPER.readValue(information, StatusUpdateNotificationRequest.class);
        StatusUpdateNotificationResponse response = new StatusUpdateNotificationResponse();

        if (StringUtils.isEmpty(request.getNotifycationSignature())
            || StringUtils.isEmpty(request.getStatusUpdateNotification())) {
            // failure, the response set by yourself
            response.setErrorCode("1");
            response.setErrorMsg("the notification message is empty");
            return;
        }

        // verify the notification
        boolean isCheckOk =
            doCheck(request.getStatusUpdateNotification(), request.getNotifycationSignature(), PUBLIC_KEY);
        if (!isCheckOk) {
            // failure, the response set by yourself
            response.setErrorCode("2");
            response.setErrorMsg("verify the sign failure");
            return;
        }

        // TODO replace with your business logic
        StatusUpdateNotification statusUpdateNotification =
            MAPPER.readValue(request.getStatusUpdateNotification(), StatusUpdateNotification.class);
        int notificationType = statusUpdateNotification.getNotificationType();
        switch (notificationType) {
            case NotificationType.INITIAL_BUY:
                break;
            case NotificationType.CANCEL:
                break;
            case NotificationType.RENEWAL:
                break;
            case NotificationType.INTERACTIVE_RENEWAL:
                break;
            case NotificationType.NEW_RENEWAL_PREF:
                break;
            case NotificationType.RENEWAL_STOPPED:
                break;
            case NotificationType.RENEWAL_RESTORED:
                break;
            case NotificationType.RENEWAL_RECURRING:
                break;
            case NotificationType.ON_HOLD:
                break;
            case NotificationType.PAUSED:
                break;
            case NotificationType.PAUSE_PLAN_CHANGED:
                break;
            case NotificationType.PRICE_CHANGE_CONFIRMED:
                break;
            case NotificationType.DEFERRED:
                break;
            default:
                break;
        }

    }

    /**
     * check RSA signature
     *
     * @param content content
     * @param sign sign
     * @param publicKey publicKey
     * @return boolean
     */
    public static boolean doCheck(String content, String sign, String publicKey) {
        if (StringUtils.isEmpty(sign)) {
            return false;
        }
        if (StringUtils.isEmpty(publicKey)) {
            return false;
        }
        try {
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            byte[] encodedKey = Base64.decodeBase64(publicKey);
            PublicKey pubKey = keyFactory.generatePublic(new X509EncodedKeySpec(encodedKey));
            java.security.Signature signature;
            signature = java.security.Signature.getInstance("SHA256WithRSA");
            signature.initVerify(pubKey);
            signature.update(content.getBytes(StandardCharsets.UTF_8));
            byte[] bsign = Base64.decodeBase64(sign);
            return signature.verify(bsign);
        } catch (RuntimeException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
