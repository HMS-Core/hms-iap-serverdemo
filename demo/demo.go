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
  "bytes"
  "crypto"
  "crypto/rsa"
  "crypto/sha256"
  "crypto/x509"
  "encoding/base64"
  "encoding/json"
  "io/ioutil"
  "net/http"
  "time"
)

// default http client with 5 seconds timeout
var RequestHttpClient = http.Client{Timeout: time.Second * 5}

func SendRequest(url string, bodyMap map[string]string) (string, error) {
  authHeaderString, err := BuildAuthorization()
  if err != nil {
    return "", err
  }
  bodyString, err := json.Marshal(bodyMap)
  if err != nil {
    return "", err
  }

  req, err := http.NewRequest("POST", url, bytes.NewReader(bodyString))
  if err != nil {
    return "", err
  }
  req.Header.Set("Content-Type", "application/json; charset=UTF-8")
  req.Header.Set("Authorization", authHeaderString)
  response, err := RequestHttpClient.Do(req)
  defer response.Body.Close()
  bodyBytes, err := ioutil.ReadAll(response.Body)
  if err != nil {
    return "", err
  }
  return string(bodyBytes), nil
}

func VerifyRsaSign(content string, sign string, publicKey string) error {
  publicKeyByte, err := base64.StdEncoding.DecodeString(publicKey)
  if err != nil {
    return err
  }
  pub, err := x509.ParsePKIXPublicKey(publicKeyByte)
  if err != nil {
    return err
  }
  hashed := sha256.Sum256([]byte(content))
  signature, err := base64.StdEncoding.DecodeString(sign)
  if err != nil {
    return err
  }
  return rsa.VerifyPKCS1v15(pub.(*rsa.PublicKey), crypto.SHA256, hashed[:], signature)
}
