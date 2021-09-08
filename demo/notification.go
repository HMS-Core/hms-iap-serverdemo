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

import "encoding/json"

const (
  INITIAL_BUY            = 0
  CANCEL                 = 1
  RENEWAL                = 2
  INTERACTIVE_RENEWAL    = 3
  NEW_RENEWAL_PREF       = 4
  RENEWAL_STOPPED        = 5
  RENEWAL_RESTORED       = 6
  RENEWAL_RECURRING      = 7
  ON_HOLD                = 9
  PAUSED                 = 10
  PAUSE_PLAN_CHANGED     = 11
  PRICE_CHANGE_CONFIRMED = 12
  DEFERRED               = 13
)

type NotificationServer struct {
}

var NotificationDemo = &NotificationServer{}

type NotificationRequest struct {
  StatusUpdateNotification string `json:"statusUpdateNotification"`
  NotificationSignature    string `json:"notifycationSignature"`
}

type NotificationResponse struct {
  ErrorCode string `json:"errorCode"`
  ErrorMsg  string `json:"errorMsg"`
}

type StatusUpdateNotification struct {
  Environment                       string `json:"environment"`
  NotificationType                  int    `json:"notificationType"`
  SubscriptionID                    string `json:"subscriptionId"`
  CancellationDate                  int64  `json:"cancellationDate"`
  OrderID                           string `json:"orderId"`
  LatestReceipt                     string `json:"latestReceipt"`
  LatestReceiptInfo                 string `json:"latestReceiptInfo"`
  LatestReceiptInfoSignature        string `json:"latestReceiptInfoSignature"`
  LatestExpiredReceipt              string `json:"latestExpiredReceipt"`
  LatestExpiredReceiptInfo          string `json:"latestExpiredReceiptInfo"`
  LatestExpiredReceiptInfoSignature string `json:"latestExpiredReceiptInfoSignature"`
  AutoRenewStatus                   int    `json:"autoRenewStatus"`
  RefundPayOrderId                  string `json:"refundPayOrderId"`
  ProductID                         string `json:"productId"`
  ApplicationID                     string `json:"applicationId"`
  ExpirationIntent                  int    `json:"expirationIntent"`
}

func (eventServer *NotificationServer) DealNotification(information string) (*NotificationResponse, error) {
  var request NotificationRequest
  err := json.Unmarshal([]byte(information), &request)
  if err != nil {
    return nil, err
  }
  err = VerifyRsaSign(request.StatusUpdateNotification, request.NotificationSignature, DefaultConfig.ApplicationPublicKey)
  if err != nil {
    return nil, err
  }

  var info StatusUpdateNotification
  json.Unmarshal([]byte(request.StatusUpdateNotification), &info)
  switch notificationType := info.NotificationType; notificationType {
  case INITIAL_BUY:
  case CANCEL:
  case RENEWAL:
  case INTERACTIVE_RENEWAL:
  case NEW_RENEWAL_PREF:
  case RENEWAL_STOPPED:
  case RENEWAL_RESTORED:
  case RENEWAL_RECURRING:
  case ON_HOLD:
  case PAUSED:
  case PAUSE_PLAN_CHANGED:
  case PRICE_CHANGE_CONFIRMED:
  case DEFERRED:
  default:
  }

  response := NotificationResponse{ErrorCode: "0"}
  return &response, nil

}
