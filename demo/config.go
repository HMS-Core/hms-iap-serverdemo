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

type DemoConfig struct {
  ClientSecret         string
  ClientId             string
  TokenUrl             string
  ApplicationPublicKey string
}

func GetDefaultConfig() *DemoConfig {
  var demoConfig DemoConfig
  // your client secret
  demoConfig.ClientSecret = "appsecret"
  // your app id
  demoConfig.ClientId = "1234567"
  // application public key, base64 encode
  demoConfig.ApplicationPublicKey = "public key, base64 encode"

  // product token url
  // demoConfig.tokenUrl = "https://oauth-login.cloud.huawei.com/oauth2/v3/token";

  demoConfig.TokenUrl = "http://exampleserver/_mockserver_/oauth2/v3/token"
  return &demoConfig
}

var DefaultConfig = GetDefaultConfig()
