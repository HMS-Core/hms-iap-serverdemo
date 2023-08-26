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
The Demo Class For OrderService request
"""
import json
import AtDemo


class OrderService:
    """
    Demo Service To Request To Order Server
    """
    def __init__(self):
        # TODO: replace the (ip:port) to the real one, and if the protocol is https, you should deal with the license
        self.TOC_SITE_URL = "http://ip:port"
        self.verifyTokenUrl = "%s/applications/purchases/tokens/verify"
        self.cancelledListPurchaseUrl = "%s/applications/v2/purchases/cancelledList"
        self.confirmPurchaseUrl = "%s/applications/v2/purchases/confirm"

    def verifyToken(self, purchaseToken, productId):
        # fetch the App Level AccessToken
        appAt = AtDemo.getAppAT()
        if appAt is None or appAt == "":
            return
        # construct the Authorization in Header
        headers = AtDemo.buildAuthorization(appAt)
        # pack the request body
        bodyDict = {"purchaseToken": purchaseToken, "productId": productId}
        data = json.dumps(bodyDict)
        response = AtDemo.httpPost(self.verifyTokenUrl % self.TOC_SITE_URL, str.encode(data), headers)
        # TODO: display the response as string in console, you can replace it with your business logic.
        print(response)

    def cancelledListPurchase(self, endAt, startAt, maxRows, queryType, continuationToken):
        # fetch the App Level AccessToken
        appAt = AtDemo.getAppAT()
        if appAt is None or appAt == "":
            return
        # construct the Authorization in Header
        headers = AtDemo.buildAuthorization(appAt)
        # pack the request body
        bodyDict = {"endAt": endAt, "startAt": startAt, "maxRows": maxRows, "type": queryType,
                    "continuationToken": continuationToken}
        data = json.dumps(bodyDict)
        response = AtDemo.httpPost(self.cancelledListPurchaseUrl % self.TOC_SITE_URL, str.encode(data), headers)
        # TODO: display the response as string in console, you can replace it with your business logic.
        print(response)

    def confirmPurchase(self, purchaseToken, productId):
        # fetch the App Level AccessToken
        appAt = AtDemo.getAppAT()
        if appAt is None or appAt == "":
            return
        # construct the Authorization in Header
        headers = AtDemo.buildAuthorization(appAt)
        # pack the request body
        bodyDict = {"purchaseToken": purchaseToken, "productId": productId}
        data = json.dumps(bodyDict)
        response = AtDemo.httpPost(self.confirmPurchaseUrl % self.TOC_SITE_URL, str.encode(data), headers)
        # TODO: display the response as string in console, you can replace it with your business logic.
        print(response)
