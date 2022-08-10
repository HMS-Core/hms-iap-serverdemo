# Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
"""
The Demo Class For AccessToken request
"""
import json
import urllib.request
import urllib.parse
import base64
import ssl

"""The Demo Class For AccessToken request."""
# TODO: The values of (clientId, clientSecret, TokenUrl) should be replaced with the actual one.
# your client secret
clientSecret = "appsecret"
# your app id
clientId = "1234567"
# token url to get the authorization
TokenUrl = "https://oauth-login.cloud.huawei.com/oauth2/v3/token"
# The accessToken.
accessToken = None


def getAppAT():
    """Get App Level AccessToken."""
    global accessToken
    # if accessToken exist, use directly
    if accessToken is not None and accessToken != "":
        return accessToken
    headers = {'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'}
    bodyDict = {"grant_type": "client_credentials", "client_secret": clientSecret, "client_id": clientId}
    data = urllib.parse.urlencode(bodyDict).encode("utf-8")
    response = httpPost(TokenUrl, data, headers, 0)
    if response is not None and response != "":
        jsonObject = json.loads(response)
        accessToken = jsonObject['access_token']
        # TODO: display the accessToken in console, you can remove it
        print(accessToken)
    return accessToken


def httpPost(url, params, headers, enhancedSafety = 1):
    """Http post function."""
    global accessToken
    response, statusCode = doPost(url, params, headers, enhancedSafety)
    # when statusCode is 401, means AT is expired
    if statusCode == 401:
        # refresh AT
        accessToken = None
        appAt = getAppAT()
        headers = buildAuthorization(appAt)
        # request again
        response, statusCode = doPost(url, params, headers, enhancedSafety)
    elif statusCode != 200:
        print("request error: " + response)
        response = None
    return response


def doPost(url, params, headers, enhancedSafety = 1):
    """do post request"""
    try:
        errorPro = BetterHTTPErrorProcessor()
        opener = ""
        if enhancedSafety == 1: 
            scontext = ssl.SSLContext(ssl.PROTOCOL_TLSv1_2)
            scontext.set_ciphers("TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256")
            httpshandler = urllib.request.HTTPSHandler(context=scontext)
            opener = urllib.request.build_opener(errorPro, httpshandler)
        else:
            opener = urllib.request.build_opener(errorPro)

        # urllib.request.install_opener(opener)
        req = urllib.request.Request(url=url, data=params, headers=headers, unverifiable=False, method="POST")
        # response = urllib.request.urlopen(req, timeout=50)
        response = opener.open(req, timeout=50)
        statusCode = response.getcode()
        return str(response.read(), encoding="utf8"), statusCode
    except urllib.error.URLError as e:
        print(e)


def buildAuthorization(appAt):
    """Build Authorization in Header"""
    oriString = "APPAT:%s" % appAt
    authorization = "Basic %s" % str(base64.b64encode(oriString.encode('utf-8')), 'utf-8')
    headers = {"Authorization": authorization, "Content-Type": "application/json; charset=UTF-8"}
    return headers


class BetterHTTPErrorProcessor(urllib.request.HTTPErrorProcessor):
    """rewrite HTTPErrorProcessor."""
    handler_order = 1000  # after all other processing

    def http_response(self, request, response):
        code, msg, hdrs = response.code, response.msg, response.info()
        # request was successfully received, understood, and accepted.
        if not (200 <= code < 500):
            response = self.parent.error(
                'http', request, response, code, msg, hdrs)
        return response
    https_response = http_response
