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
package demo_test

import (
	"iap-golang-sample/demo"
	"log"
	"testing"
)

func TestAll(t *testing.T) {
	at, err := demo.AtDemo.GetAppAt()
	if err != nil {
		t.Errorf("err is %s", err)
	}
	log.Printf("at=%s", at)
	demo.OrderDemo.VerifyToken("demoToken", "demoProductId", 0)
	demo.OrderDemo.ConfirmPurchase("demoToken", "demoProductId", 0)
	demo.OrderDemo.CancelledListPurchase(123, 456, 100, 0, "demoToken", 0)

	demo.SubscriptionDemo.GetSubscription("demoId", "demoToken", 0)
	demo.SubscriptionDemo.StopSubscription("demoId", "demoToken", 0)
	demo.SubscriptionDemo.DelaySubscription("demoId", "demoToken", 123, 456, 0)
	demo.SubscriptionDemo.ReturnFeeSubscription("demoId", "demoToken", 0)
	demo.SubscriptionDemo.WithdrawalSubscription("demoId", "demoToken", 0)
}
