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

/**
 * 功能描述
 *
 * @author iap
 * @since 2020-02-05
 */
public class StatusUpdateNotification {
    private String environment;

    private Integer notificationType;

    private String subscriptionId;

    private Long cancellationDate;

    private String orderId;

    private String latestReceipt;

    private String latestReceiptInfo;

    private String latestReceiptInfoSignature;

    private String latestExpiredReceipt;

    private String latestExpiredReceiptInfo;

    private String latestExpiredReceiptInfoSignature;

    private Integer autoRenewStatus;

    private String refundPayOrderId;

    private String productId;

    private String applicationId;

    private Integer expirationIntent;

    public String getEnvironment() {
        return environment;
    }

    public void setEnvironment(String environment) {
        this.environment = environment;
    }

    public Integer getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(Integer notificationType) {
        this.notificationType = notificationType;
    }

    public String getSubscriptionId() {
        return subscriptionId;
    }

    public void setSubscriptionId(String subscriptionId) {
        this.subscriptionId = subscriptionId;
    }

    public Long getCancellationDate() {
        return cancellationDate;
    }

    public void setCancellationDate(Long cancellationDate) {
        this.cancellationDate = cancellationDate;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getLatestReceipt() {
        return latestReceipt;
    }

    public void setLatestReceipt(String latestReceipt) {
        this.latestReceipt = latestReceipt;
    }

    public String getLatestReceiptInfo() {
        return latestReceiptInfo;
    }

    public void setLatestReceiptInfo(String latestReceiptInfo) {
        this.latestReceiptInfo = latestReceiptInfo;
    }

    public String getLatestReceiptInfoSignature() {
        return latestReceiptInfoSignature;
    }

    public void setLatestReceiptInfoSignature(String latestReceiptInfoSignature) {
        this.latestReceiptInfoSignature = latestReceiptInfoSignature;
    }

    public String getLatestExpiredReceipt() {
        return latestExpiredReceipt;
    }

    public void setLatestExpiredReceipt(String latestExpiredReceipt) {
        this.latestExpiredReceipt = latestExpiredReceipt;
    }

    public String getLatestExpiredReceiptInfo() {
        return latestExpiredReceiptInfo;
    }

    public void setLatestExpiredReceiptInfo(String latestExpiredReceiptInfo) {
        this.latestExpiredReceiptInfo = latestExpiredReceiptInfo;
    }

    public String getLatestExpiredReceiptInfoSignature() {
        return latestExpiredReceiptInfoSignature;
    }

    public void setLatestExpiredReceiptInfoSignature(String latestExpiredReceiptInfoSignature) {
        this.latestExpiredReceiptInfoSignature = latestExpiredReceiptInfoSignature;
    }

    public Integer getAutoRenewStatus() {
        return autoRenewStatus;
    }

    public void setAutoRenewStatus(Integer autoRenewStatus) {
        this.autoRenewStatus = autoRenewStatus;
    }

    public String getRefundPayOrderId() {
        return refundPayOrderId;
    }

    public void setRefundPayOrderId(String refundPayOrderId) {
        this.refundPayOrderId = refundPayOrderId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(String applicationId) {
        this.applicationId = applicationId;
    }

    public Integer getExpirationIntent() {
        return expirationIntent;
    }

    public void setExpirationIntent(Integer expirationIntent) {
        this.expirationIntent = expirationIntent;
    }
}
