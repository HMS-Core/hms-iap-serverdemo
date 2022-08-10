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
class SubscriptionService

# TODO: replace the (ip:port) to the real one. If the protocol is https,
# TODO:you should deal with the license
  TOC_SITE_URL = 'https://ip:port'

  TOBTOC_SITE_URL = 'https://subscr-at-dre.iap.cloud.huawei.eu'

  def getRootUrl(accountFlag)
    if (accountFlag != nil && accountFlag == 1)
      return TOBTOC_SITE_URL;
    end
      return TOC_SITE_URL;
  end

  def getSubscription(subscriptionId, purchaseToken,accountFlag)
    atDemo = AtDemo.new
    headers = atDemo.buildAuthorization(atDemo.getAppAt)

    body = {'subscriptionId' => subscriptionId,
            'purchaseToken' => purchaseToken}

    rsp = atDemo.apiHttpsPost(getRootUrl(accountFlag)+ "/sub/applications/v2/purchases/get", headers, body.to_json)
    puts rsp.body
  end

  def stopSubscription(subscriptionId, purchaseToken,accountFlag)
    atDemo = AtDemo.new
    headers = atDemo.buildAuthorization(atDemo.getAppAt)

    body = {'subscriptionId' => subscriptionId,
            'purchaseToken' => purchaseToken}

    rsp = atDemo.apiHttpsPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/stop", headers, body.to_json)
    puts rsp.body
  end

  def delaySubscription(subscriptionId, purchaseToken, currentExpirationTime,
                        desiredExpirationTime,accountFlag)
    atDemo = AtDemo.new
    headers = atDemo.buildAuthorization(atDemo.getAppAt)

    body = {'subscriptionId' => subscriptionId,
            'purchaseToken' => purchaseToken,
            'currentExpirationTime' => currentExpirationTime,
            'desiredExpirationTime' => desiredExpirationTime}

    rsp = atDemo.apiHttpsPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/delay", headers, body.to_json)
    puts rsp.body
  end

  def returnFeeSubscription(subscriptionId, purchaseToken,accountFlag)
    atDemo = AtDemo.new
    headers = atDemo.buildAuthorization(atDemo.getAppAt)

    body = {'subscriptionId' => subscriptionId,
            'purchaseToken' => purchaseToken
    }

    rsp = atDemo.apiHttpsPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/returnFee", headers, body.to_json)
    puts rsp.body
  end


  def withdrawSubscription(subscriptionId, purchaseToken,accountFlag)
    atDemo = AtDemo.new
    headers = atDemo.buildAuthorization(atDemo.getAppAt)

    body = {'subscriptionId' => subscriptionId,
            'purchaseToken' => purchaseToken
    }

    rsp = atDemo.apiHttpsPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/withdrawal", headers, body.to_json)
    puts rsp.body
  end

end