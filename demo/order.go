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

type OrderClient struct {
}

var OrderDemo = &OrderClient{}

func getOrderUrl(accountFlag int) string {
  if accountFlag == 1 {
    // site for telecom carrier
    return  "https://orders-at-dre.iap.dbankcloud.com"
  } else
  {
    // TODO: replace the (ip:port) to the real one
    return  "http://exampleserver/_mockserver_"
  }

}

func (orderDemo *OrderClient) VerifyToken(purchaseToken, productId string, accountFlag int) {
  bodyMap := map[string]string{"purchaseToken": purchaseToken, "productId": productId}
  url := getOrderUrl(accountFlag)+ "/applications/purchases/tokens/verify"
  bodyBytes, err := SendRequest(url, bodyMap)
  if err != nil {
    log.Printf("err is %s", err)
  }
  // TODO: display the response as string in console, you can replace it with your business logic.
  log.Printf("%s", bodyBytes)
}

func (orderDemo *OrderClient) CancelledListPurchase(endAt int64, startAt int64, maxRows int, productType int, continuationToken string,accountFlag int) {
  bodyMap := map[string]string{
    "endAt":             fmt.Sprintf("%v", endAt),
    "startAt":           fmt.Sprintf("%v", startAt),
    "maxRows":           fmt.Sprintf("%v", maxRows),
    "type":              fmt.Sprintf("%v", productType),
    "continuationToken": continuationToken,
  }
  url := getOrderUrl(accountFlag)+ "/applications/v2/purchases/cancelledList"
  bodyBytes, err := SendRequest(url, bodyMap)
  if err != nil {
    log.Printf("err is %s", err)
  }
  // TODO: display the response as string in console, you can replace it with your business logic.
  log.Printf("%s", bodyBytes)
}

func (orderDemo *OrderClient) ConfirmPurchase(purchaseToken, productId string,accountFlag int) {
  bodyMap := map[string]string{
    "purchaseToken":             purchaseToken,
    "productId":          productId,
  }
  url := getOrderUrl(accountFlag)+ "/applications/v2/purchases/confirm"
  bodyBytes, err := SendRequest(url, bodyMap)
  if err != nil {
    log.Printf("err is %s", err)
  }
  // TODO: display the response as string in console, you can replace it with your business logic.
  log.Printf("%s", bodyBytes)
}
