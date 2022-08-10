=begin
Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
=end
require_relative 'at_demo'
class OrderService

  # TODO: replace the (ip:port) to the real one. If the protocol is https,
  # TODO:you should deal with the license
  TOC_SITE_URL = 'https://ip:port'

  TOBTOC_SITE_URL = 'https://orders-at-dre.iap.cloud.huawei.eu'

  def getRootUrl(accountFlag)
    if (accountFlag != nil && accountFlag == 1)
        return TOBTOC_SITE_URL;
    end
    return TOC_SITE_URL;
  end

  def verifyToken(purchaseToken, productId,accountFlag)
    atDemo = AtDemo.new
    headers = atDemo.buildAuthorization(atDemo.getAppAt)

    body = {'purchaseToken' => purchaseToken,
            'productId' => productId}

    rsp=atDemo.apiHttpsPost(getRootUrl(accountFlag) + '/applications/purchases/tokens/verify', headers, body.to_json)
    puts rsp.body
  end

  def cancelledListPurchase(endAt, startAt, maxRows, type,
                            continuationToken,accountFlag)
    atDemo = AtDemo.new
    headers = atDemo.buildAuthorization(atDemo.getAppAt)

    body = {'endAt' => endAt,
            'startAt' => startAt,
            'maxRows' => maxRows,
            'type' => type,
            'continuationToken' => continuationToken}
    rsp= atDemo.apiHttpsPost(getRootUrl(accountFlag) + "/applications/v2/purchases/cancelledList",headers, body.to_json)
    puts rsp.body
  end

  def confirmPurchase(accountFlag,purchaseToken,productId)
    atDemo = AtDemo.new
    headers = atDemo.buildAuthorization(atDemo.getAppAt)

    body = {'purchaseToken' => purchaseToken,
            'productId' => productId,
           }
    rsp= atDemo.apiHttpsPost(getRootUrl(accountFlag) + "/applications/v2/purchases/confirm",headers, body.to_json)
    puts rsp.body
  end
end