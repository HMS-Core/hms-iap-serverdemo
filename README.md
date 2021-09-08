## iap-python-sample


## Table of Contents

 * [Introduction](#introduction)
 * [Installation](#installation)
 * [Configuration ](#configuration )
 * [Supported Environments](#supported-environments)
 * [Sample Code](#Sample Code)
 * [License](#license)
 
 
## Introduction
    Python sample code encapsulates APIs of the HUAWEI IAP server. It provides many sample programs for your reference or usage.
    The following describes packages of python sample code.
    
    AtDemo:               Sample code of AccessToken. Each method can run independently.
    OrderService:         Sample code of OrderService. Each method can run independently.
    SubscriptionService:  Sample code of SubscriptionService. Each method can run independently.

## Installation
    Before using python sample code, check whether the python environment has been installed. 
    Install pycryptodome: pip install pycryptodome.
    Decompress the python sample code package.
    
    Copy the python sample package in the decompressed folder to the project vendor directory in the path specified by PYTHONPATH.
    Refresh the project and ensure that the file is successfully copied to the destination directory.
    
## Supported Environments
	Python 3.5+ .  
    
## Configuration
    To use functions provided in examples, you need to set related parameters in AtDemo.py, OrderService.py and SubscriptionService.py in the package.
    
    The following describes parameters in AtDemo.py.
    clientId:      Client ID, which is obtained from app information.
    clientSecret:  Secret access key of an app, which is obtained from app information.
    tokenUrl:      URL for the Huawei OAuth 2.0 service to obtain a token, please refer to Generating an App-Level Access Token.
    
    The following describes parameters in OrderService.py.
    TOC_SITE_URL:      The TOC_SITE_URL has different urls at different sites, you should always choose the OrderService address of the nearest site to access.
    TOBTOC_SITE_URL:   The TOBTOC_SITE_URL has different urls at different sites, you should always choose the OrderService address of the nearest site to access. 
     
    The following describes parameters in SubscriptionService.py.
    TOC_SITE_URL:      The TOC_SITE_URL has different urls at different sites, you should always choose the OrderService address of the nearest site to access.
    TOBTOC_SITE_URL:   The TOBTOC_SITE_URL has different urls at different sites, you should always choose the OrderService address of the nearest site to access. 

## Sample Code
    Each method in the Python sample calls an API of the HUAWEI IAP server.
    The following describes methods in the Python sample.
    
    1). AtDemo: getAppAT()
    You can call this method to get App Level AccessToken.
    Code location  AtDemo.py
    
    2). OrderService: verifyToken()
    You can call this method to verify the purchase token in the payment result with the Huawei payment server to confirm the accuracy of the payment result.
    The URL is {rootUrl}/applications/purchases/tokens/verify. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location  OrderService.py
    
    3). OrderService: cancelledListPurchase()
    You can call this method to pagination query all purchase information that has been cancelled or has a refund.
    The URL is {rootUrl}/applications/{apiVersion}/purchases/cancelledList. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location  OrderService.py
    
    4). OrderService: confirmPurchase()
    You can call this method to confirm purchase information.
    The URL is {rootUrl}/applications/{apiVersion}/purchases/confirm. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location  OrderService.py
    
    5). SubscriptionService: getSubscription()
    You can call this method to verify a purchased subscription product, such as to obtain the validity period and status。
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/get. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  SubscriptionService.py
        
    6). SubscriptionService: stopSubscription()
    You can call this method to cancel an already subscribed product, the subscription is still valid during the validity period, and subsequent renewals will be terminated.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/stop. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  SubscriptionService.py
    
    7). SubscriptionService: delaySubscription()
    You can call this method to renew a subscription product for a customer until a specified time in the future. After success, the customer's subscription will expire at a future time.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/delay. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  SubscriptionService.py
    
    8). SubscriptionService: returnFeeSubscription()
    You can call this method to refund the last renewal fee of a subscription product, but the subscription product is still valid during the validity period, and subsequent renewals will be performed normally.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/returnFee. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  SubscriptionService.py
    
    9). SubscriptionService: withdrawSubscription()
    You can call this method to cancel a subscription, which is equivalent to executing the returnFeeSubscription method, and immediately ending the subscription service and subsequent renewal.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/withdrawal. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location  SubscriptionService.py
    
##  License
    IAP Python sample is licensed under the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

