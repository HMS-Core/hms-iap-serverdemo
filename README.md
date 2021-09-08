## iap-golang-sample

## Introduction
    IAP golang sample encapsulates APIs of the HUAWEI IAP server. It provides many sample programs for your reference or usage.
    The following describes sample code.
    
    config.go:           Sample code of config.
    atdemo.go:           Sample code of AccessToken. 
    order.go:            Sample code of OrderService. 
    subscription.go:     Sample code of SubscriptionService. 
    notification.go:     Sample code of notification.


## Configuration
    To use functions provided in examples, you need to set related parameters in Demo.go.
    
    The following describes parameters in class DemoConfig.
    ClientId:      Client ID, which is obtained from app information.
    ClientSecret:  Secret access key of an app, which is obtained from app information.
    TokenUrl:      URL for the Huawei OAuth 2.0 service to obtain a token, please refer to Generating an App-Level Access Token.
    ApplicationPublicKey:   Application RSA publick key, base64 encode string. 
    
    At first, the meaning of accountFlag should be clear.If field accountFlag in InappPurchaseData equals to 1, 
    the account belongs to telecom carrier(TOBTOC_SITE_URL), otherwise to Huawei(TOC_SITE_URL).  
    For both OrderService and SubscriptionService, you need to choose appropriate site.
    TOC_SITE_URL:      The TOC_SITE_URL has different urls at different sites, you should always choose the address of the nearest site to access.
    TOBTOC_SITE_URL:   The site for telecom carrier.
    

## Example Code
    Each method in the sample calls an API of the HUAWEI IAP server.
    The following describes methods in the sample.
    
    1). AtDemo: GetAppAT()
    You can call this method to get App Level AccessToken.
    Code location: atdemo.go  GetAppAt
    
    2). OrderDemo: VerifyToken()
    You can call this method to verify the purchase token in the payment result with the Huawei payment server to confirm the accuracy of the payment result.
    The URL is {orderUrl}/applications/purchases/tokens/verify. The orderUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location: order.go VerifyToken
    
    3). OrderDemo: CancelledListPurchase()
    You can call this method to pagination query all purchase information that has been cancelled or has a refund.
    The URL is {orderUrl}/applications/{apiVersion}/purchases/cancelledList. The orderUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location: order.go CancelledListPurchase 
    
    4). SubscriptionDemo: GetSubscription()
    You can call this method to verify a purchased subscription product, such as to obtain the validity period and status。
    The URL is {subscriptionUrl}/sub/applications/{apiVersion}/purchases/get. The subscriptionUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location subscription.go GetSubscription 
        
    5). SubscriptionDemo: StopSubscription()
    You can call this method to cancel an already subscribed product, the subscription is still valid during the validity period, and subsequent renewals will be terminated.
    The URL is {subscriptionUrl}/sub/applications/{apiVersion}/purchases/stop. The subscriptionUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location subscription.go StopSubscription 
    
    6). SubscriptionDemo: DelaySubscription()
    You can call this method to renew a subscription product for a customer until a specified time in the future. After success, the customer's subscription will expire at a future time.
    The URL is {subscriptionUrl}/sub/applications/{apiVersion}/purchases/delay. The subscriptionUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location subscription.go DelaySubscription 
    
    7). SubscriptionDemo: ReturnFeeSubscription()
    You can call this method to refund the last renewal fee of a subscription product, but the subscription product is still valid during the validity period, and subsequent renewals will be performed normally.
    The URL is {subscriptionUrl}/sub/applications/{apiVersion}/purchases/returnFee. The subscriptionUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location subscription.go ReturnFeeSubscription 
    
    8). SubscriptionDemo: WithdrawalSubscription()
    You can call this method to cancel a subscription, which is equivalent to executing the returnFeeSubscription method, and immediately ending the subscription service and subsequent renewal.
    The URL is {subscriptionUrl}/sub/applications/{apiVersion}/purchases/withdrawal. The subscriptionUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location subscription.go WithdrawalSubscription 

    9). NotificationDemo: DealNotification()
    You can call this method to handle subscription event notifications.
    The information parameter is obtained from subscription event notification.
    Code location notification.go DealNotification()
    
    10). OrderService: confirmPurchase()
    You can call this method to confirm purchase after sending out product.
    The URL is {rootUrl}/applications/{apiVersion}/purchases/confirm. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location OrderService.go

##  License
    IAP golang sample is licensed under the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).


