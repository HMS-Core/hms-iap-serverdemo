## iap-ruby-sample


## Table of Contents

 * [Introduction](#introduction)
 * [Installation](#installation)
 * [Configuration ](#configuration )
 * [Supported Environments](#supported-environments)
 * [Sample Code](#Sample Code)
 * [License](#license)
 
 
## Introduction
    Ruby sample code encapsulates APIs of the HUAWEI IAP server. It provides many sample programs for your reference or usage.
    The following describes class of Ruby sample code.
    
    AtDemo:               Sample code of AccessToken. Each method can run independently.
    OrderService:         Sample code of OrderService. Each method can run independently.
    SubscriptionService:  Sample code of SubscriptionService. Each method can run independently.

## Installation
    Before using Ruby sample code, check whether the Ruby environment has been installed. 
    Decompress the Ruby sample code package.
    
    Copy the Ruby sample package in the decompressed folder to the project vendor directory .
    Refresh the project and ensure that the file is successfully copied to the destination directory.
    
## Supported Environments
	Ruby 2.6.5+ .  
    
## Configuration
    To use functions provided in examples, you need to set related parameters in at_demo.rb, order_service.rb 
    and subscription_service.rb in the package.
    
    The following describes parameters in at_demo.rb.
    CLIENT_ID:      Client ID, which is obtained from app information.
    CLIENT_SECRET:  Secret access key of an app, which is obtained from app information.
    TOKEN_URL:      URL for the Huawei OAuth 2.0 service to obtain a token, please refer to Generating an App-Level Access Token.
    
    At first, the meaning of accountFlag should be clear.If field accountFlag in InappPurchaseData equals to 1, 
    the account belongs to telecom carrier(TOBTOC_SITE_URL), otherwise to Huawei(TOC_SITE_URL).  
    For both OrderService and SubscriptionService, you need to choose appropriate site.
    TOC_SITE_URL:      The TOC_SITE_URL has different urls at different sites, you should always choose the address of the nearest site to access.
    TOBTOC_SITE_URL:   The site for telecom carrier.
    
## Sample Code
    Each method in the Ruby sample calls an API of the HUAWEI IAP server.
    The following describes methods in the Ruby sample.
    
    1). AtDemo: getAppAT()
    You can call this method to get App Level AccessToken.
    Code location  at_demo.rb
    
    2). OrderService: verifyToken()
    You can call this method to verify the purchase token in the payment result with the Huawei payment server to confirm the accuracy of the payment result.
    The URL is {rootUrl}/applications/purchases/tokens/verify. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location  order_service.rb
    
    3). OrderService: cancelledListPurchase()
    You can call this method to pagination query all purchase information that has been cancelled or has a refund.
    The URL is {rootUrl}/applications/{apiVersion}/purchases/cancelledList. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location  order_service.rb
    
    4). SubscriptionService: getSubscription()
    You can call this method to verify a purchased subscription product, such as to obtain the validity period and status。
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/get. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  subscription_service.rb
        
    5). SubscriptionService: stopSubscription()
    You can call this method to cancel an already subscribed product, the subscription is still valid during the validity period, and subsequent renewals will be terminated.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/stop. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  subscription_service.rb
    
    6). SubscriptionService: delaySubscription()
    You can call this method to renew a subscription product for a customer until a specified time in the future. After success, the customer's subscription will expire at a future time.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/delay. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  subscription_service.rb
    
    7). SubscriptionService: returnFeeSubscription()
    You can call this method to refund the last renewal fee of a subscription product, but the subscription product is still valid during the validity period, and subsequent renewals will be performed normally.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/returnFee. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  subscription_service.rb
    
    8). SubscriptionService: withdrawSubscription()
    You can call this method to cancel a subscription, which is equivalent to executing the returnFeeSubscription method, and immediately ending the subscription service and subsequent renewal.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/withdrawal. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  subscription_service.rb
    
    10). OrderService: confirmPurchase()
    You can call this method to confirm purchase after sending out product.
    The URL is {rootUrl}/applications/{apiVersion}/purchases/confirm. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location  order_service.rb
    
##  License
    IAP Ruby sample is licensed under the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

