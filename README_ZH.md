## 应用内支付服务示例代码

中文 | [English](README.md)

## 目录

 * [简介](#简介)
 * [安装](#安装)
 * [环境要求](#环境要求)
 * [配置 ](#配置 )
 * [示例代码](#示例代码)
 * [授权许可](#授权许可)


## 简介
华为应用内支付服务示例代码将华为应用内支付的服务端接口进行封装，提供丰富的示例程序供您参考或使用。示例代码如下：

AtDemo：AccessToken示例代码，各方法可独立运行。
OrderService：OrderService示例代码，各方法可独立运行。
SubscriptionService：SubscriptionService示例代码，各方法可独立运行。
notification：notification示例代码，各方法可独立运行。

## 安装
使用示例代码前，请确保已安装Java运行环境，并解压示例代码压缩包。
复制解压后的示例代码包至环境变量JAVAPATH指定的目录下。
刷新项目，确保您的文件已成功复制至目标目录下。

## 环境要求
建议使用JDK 1.8版本或以上。    

## 配置
如需使用示例代码中的功能，需在AtDemo.java、OrderService.java、SubscriptionService.java和AppServer.java中设置相关参数。

AtDemo.java包括如下参数：
clientId：Client ID，可从应用信息中获取。
clientSecret：Client Secret，可从应用信息中获取。
tokenUrl：Huawei OAuth 2.0服务通过此URL获取令牌，请参考[基于OAuth 2.0开放鉴权](https://developer.huawei.com/consumer/cn/doc/development/HMSCore-Guides/open-platform-oauth-0000001053629189?ha_source=hms1)。

notification和AppServer.java包括如下参数：
PUBLIC_KEY：RSA公钥。

首先，需明确accountFlag定义。如果InappPurchaseData中accountFlag字段等于1， 账户属于电信运营商（TOBTOC_SITE_URL）；如果不等于1，则属于华为（TOC_SITE_URL）。  
对于OrderService和SubscriptionService，您需要选择合适的站点。
TOC_SITE_URL：站点不同，URL不同，请选择最近的站点接入。
TOBTOC_SITE_URL：电信运营商站点。

## 示例代码
示例代码中的方法调用华为应用内支付的服务端接口。
具体方法如下：
    
1. AtDemo: getAppAT()
   您可以调用该方法，获取应用级Access Token。
   代码位置：src/main/java/com/example/demo/AtDemo.java
2. OrderService: verifyToken()
    您可以调用该方法，使用华为支付服务器，验证支付结果中的购买Token，确保支付结果的准确性。
    URL为{rootUrl}/applications/purchases/tokens/verify。站点不同，rootUrl的URL不同，请选择Order服务最近站点接入。
    代码位置：src/main/java/com/example/demo/OrderService.java
3. OrderService: cancelledListPurchase()
    您可以调用该方法，对取消或退款的购买信息进行分页查询。
    URL为{rootUrl}/applications/{apiVersion}/purchases/cancelledList。rootUrl的URL不同, 请选择Order服务最近站点接入。
    代码位置：src/main/java/com/example/demo/OrderService.java
4. SubscriptionService: getSubscription()
    您可以调用该方法，对已购买的订阅商品进行校验，如获取有效期及状态。
    URL为{rootUrl}/sub/applications/{apiVersion}/purchases/get。站点不同，rootUrl的URL不同, 请选择Subscription服务最近站点接入。
    代码位置：src/main/java/com/example/demo/SubscriptionService.java
5. SubscriptionService: stopSubscription()
    您可以调用该方法，取消已订阅商品。商品在当前订阅周期结束前仍然有效，但后续的续费会终止。rootUrl的URL不同, 请选择Subscription服务最近站点接入。
    URL为{rootUrl}/sub/applications/{apiVersion}/purchases/stop。
    代码位置：src/main/java/com/example/demo/SubscriptionService.java
6. SubscriptionService: delaySubscription()
    您可以调用该方法，将用户的下一个结算日期推迟。调用成功，系统会根据延迟时间更新订阅续订日期。
    URL为{rootUrl}/sub/applications/{apiVersion}/purchases/delay。站点不同，rootUrl的URL不同, 请选择Subscription服务最近站点接入。
    代码位置：src/main/java/com/example/demo/SubscriptionService.java
7. SubscriptionService: returnFeeSubscription()
    您可以调用该方法进行最近一次收据的退费操作。不会对订阅产生额外影响，订阅可以继续正常使用，到期后也会进行自动续费。
    URL为{rootUrl}/sub/applications/{apiVersion}/purchases/returnFee。站点不同，rootUrl的URL不同, 请选择Subscription service最近站点接入。
    代码位置：src/main/java/com/example/demo/SubscriptionService.java

8. SubscriptionService: withdrawSubscription()
    您可以调用该方法，撤销订阅来终止服务，购买的订阅型商品立即消失，同事这笔订阅费用会立即发起返还（returnFeeSubscription)。站点不同，rootUrl的URL不同, 请选择Subscription服务最近站点接入。
    URL为{rootUrl}/sub/applications/{apiVersion}/purchases/withdrawal
    代码位置：src/main/java/com/example/demo/SubscriptionService.java
9. AppServer: dealNotification()
    您可以调用该方法，处理订阅消息。
    从订阅消息中获取相关参数。
    代码位置：src/main/java/com/example/demo/notification/AppServer.java
10. OrderService: confirmPurchase()
    您可以调用该方法，在发货后确认购买。
    URL为{rootUrl}/applications/{apiVersion}/purchases/confirm。站点不同，rootUrl的URL不同, 请选择Order服务最近站点接入。
    代码位置：OrderService.java

##  授权许可
华为应用内支付服务示例代码经过[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)授权许可。

