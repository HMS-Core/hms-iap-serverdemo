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
public class StatusUpdateNotificationRequest {
    private String statusUpdateNotification;

    private String notifycationSignature;

    public String getStatusUpdateNotification() {
        return statusUpdateNotification;
    }

    public void setStatusUpdateNotification(String statusUpdateNotification) {
        this.statusUpdateNotification = statusUpdateNotification;
    }

    public String getNotifycationSignature() {
        return notifycationSignature;
    }

    public void setNotifycationSignature(String notifycationSignature) {
        this.notifycationSignature = notifycationSignature;
    }
}
