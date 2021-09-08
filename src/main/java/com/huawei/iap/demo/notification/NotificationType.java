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
public interface NotificationType {
    /**
     * The constant INITIAL_BUY.
     */
    int INITIAL_BUY = 0;

    /**
     * The constant CANCEL.
     */
    int CANCEL = 1;

    /**
     * The constant RENEWAL.
     */
    int RENEWAL = 2;

    /**
     * The constant INTERACTIVE_RENEWAL.
     */
    int INTERACTIVE_RENEWAL = 3;

    /**
     * The constant NEW_RENEWAL_PREF.
     */
    int NEW_RENEWAL_PREF = 4;

    /**
     * The constant RENEWAL_STOPPED.
     */
    int RENEWAL_STOPPED = 5;

    /**
     * The constant RENEWAL_RESTORED.
     */
    int RENEWAL_RESTORED = 6;

    /**
     * The constant RENEWAL_RECURRING.
     */
    int RENEWAL_RECURRING = 7;

    /**
     * The constant ON_HOLD.
     */
    int ON_HOLD = 9;

    /**
     * The constant PAUSED.
     */
    int PAUSED = 10;

    /**
     * The constant PAUSE_PLAN_CHANGED.
     */
    int PAUSE_PLAN_CHANGED = 11;

    /**
     * The constant PRICE_CHANGE_CONFIRMED.
     */
    int PRICE_CHANGE_CONFIRMED = 12;

    /**
     * The constant DEFERRED.
     */
    int DEFERRED = 13;
}
