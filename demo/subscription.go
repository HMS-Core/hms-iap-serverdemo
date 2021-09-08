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
package demo

import (
  "fmt"
  "log"
)

type SubscriptionClient struct {
}

var SubscriptionDemo = &SubscriptionClient{}

func getSubUrl(accountFlag int) string {
  if accountFlag == 1 {
    // site for telecom carrier
   return  "https://subscr-at-dre.iap.dbankcloud.com"
  } else
  {
    // TODO: replace the (ip:port) to the real one
    return  "http://exampleserver/_mockserver_"
  }
}

func (subscriptionDemo *SubscriptionClient) GetSubscription(subscriptionId, purchaseToken string,accountFlag int) {
  bodyMap := map[string]string{
    "subscriptionId": subscriptionId,
    "purchaseToken":  purchaseToken,
  }
  url := getSubUrl(accountFlag) + "/sub/applications/v2/purchases/get"
  bodyBytes, err := SendRequest(url, bodyMap)
  if err != nil {
    log.Printf("err is %s", err)
  }
  // TODO: display the response as string in console, you can replace it with your business logic.
  log.Printf("%s", bodyBytes)
}

func (subscriptionDemo *SubscriptionClient) StopSubscription(subscriptionId, purchaseToken string,accountFlag int) {
  bodyMap := map[string]string{
    "subscriptionId": subscriptionId,
    "purchaseToken":  purchaseToken,
  }
  url := getSubUrl(accountFlag) + "/sub/applications/v2/purchases/stop"
  bodyBytes, err := SendRequest(url, bodyMap)
  if err != nil {
    log.Printf("err is %s", err)
  }
  // TODO: display the response as string in console, you can replace it with your business logic.
  log.Printf("%s", bodyBytes)
}

func (subscriptionDemo *SubscriptionClient) DelaySubscription(subscriptionId, purchaseToken string, currentExpirationTime, desiredExpirationTime int64,accountFlag int) {
  bodyMap := map[string]string{
    "subscriptionId":        subscriptionId,
    "purchaseToken":         purchaseToken,
    "currentExpirationTime": fmt.Sprintf("%v", currentExpirationTime),
    "desiredExpirationTime": fmt.Sprintf("%v", desiredExpirationTime),
  }
  url := getSubUrl(accountFlag) + "/sub/applications/v2/purchases/delay"
  bodyBytes, err := SendRequest(url, bodyMap)
  if err != nil {
    log.Printf("err is %s", err)
  }
  // TODO: display the response as string in console, you can replace it with your business logic.
  log.Printf("%s", bodyBytes)
}

func (subscriptionDemo *SubscriptionClient) ReturnFeeSubscription(subscriptionId, purchaseToken string,accountFlag int) {
  bodyMap := map[string]string{
    "subscriptionId": subscriptionId,
    "purchaseToken":  purchaseToken,
  }
 
  url := getSubUrl(accountFlag) + "/sub/applications/v2/purchases/returnFee"
  bodyBytes, err := SendRequest(url, bodyMap)
  if err != nil {
    log.Printf("err is %s", err)
  }
  // TODO: display the response as string in console, you can replace it with your business logic.
  log.Printf("%s", bodyBytes)
}

func (subscriptionDemo *SubscriptionClient) WithdrawalSubscription(subscriptionId, purchaseToken string,accountFlag int) {
  bodyMap := map[string]string{
    "subscriptionId": subscriptionId,
    "purchaseToken":  purchaseToken,
  }
  url := getSubUrl(accountFlag) + "/sub/applications/v2/purchases/withdrawal"
  bodyBytes, err := SendRequest(url, bodyMap)
  if err != nil {
    log.Printf("err is %s", err)
  }
  // TODO: display the response as string in console, you can replace it with your business logic.
  log.Printf("%s", bodyBytes)
}
