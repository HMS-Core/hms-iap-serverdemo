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
  "encoding/base64"
  "encoding/json"
  "errors"
  "fmt"
  "io/ioutil"
  "net/url"
)

type AtResponse struct {
  AccessToken string `json:"access_token"`
}

type AtClient struct {
}

var AtDemo = &AtClient{}

func (atDemo *AtClient) GetAppAt() (string, error) {
  demoConfig := GetDefaultConfig()
  urlValue := url.Values{"grant_type": {"client_credentials"}, "client_secret": {demoConfig.ClientSecret}, "client_id": {demoConfig.ClientId}}
  resp, err := RequestHttpClient.PostForm(demoConfig.TokenUrl, urlValue)
  if err != nil {
    return "", err
  }
  defer resp.Body.Close()
  bodyBytes, err := ioutil.ReadAll(resp.Body)
  if err != nil {
    return "", err
  }
  var atResponse AtResponse
  json.Unmarshal(bodyBytes, &atResponse)
  if atResponse.AccessToken != "" {
    return atResponse.AccessToken, nil
  } else {
    return "", errors.New("Get token fail, " + string(bodyBytes))
  }
}

func BuildAuthorization() (string, error) {
  appAt, err := AtDemo.GetAppAt()
  if err != nil {
    return "", err
  }
  oriString := fmt.Sprintf("APPAT:%s", appAt)
  var authString = base64.StdEncoding.EncodeToString([]byte(oriString))
  var authHeaderString = fmt.Sprintf("Basic %s", authString)
  return authHeaderString, nil
}
