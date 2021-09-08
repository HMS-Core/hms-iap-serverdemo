## iap-php-sample

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Configuration ](#configuration )
- [Supported Environments](#supported-environments)
- [Sample Code](#Sample Code)
- [License](#license)

## Introduction

```
PhP sample code encapsulates APIs of the HUAWEI IAP server. It provides many sample programs for your reference or usage.
The following describes packages of php sample code.

at_demo:               a demo to get the token of application level.
order_service:         a demo to send requests to IAP OrderService, depends on at_demo.
subscription_service:  a demo to send requests to IAP SubscriptionService, depends on at_demo.
app_server:            a demo to deal with the IAP notification, depends on rsa_sha256.
rsa_sha256:            SHA256withRSA signature and signature verification processing algorithm.                
```

## Installation

```
Before using php sample code, check whether the php environment has been installed. The demo is based on php5.6 and support openssl. You can change the code to fit your version.

Copy the php sample file to the http server such as apache, then the code will be executed when access to the url of the sample file.
```

## Supported Environments

```
PHP 5.6 or a later version is recommended.    
```

## Configuration

```
To use functions provided in examples, you need to set related parameters in at_demo.php, order_service.php, subscription_server.php and app_server.php in the package.

The following describes parameters in at_demo.php.
CLIENT_ID:      Client ID, which is obtained from app information.
CLIENT_SECRET:  Secret access key of an app, which is obtained from app information.
TOKEN_URL:      URL for the Huawei OAuth 2.0 service to obtain a token, please refer to Generating an App-Level Access Token.

The following describes parameters in order_service.php.
TOC_SITE_URL:      The TOC_SITE_URL has different urls at different sites, you should always choose the OrderService address of the nearest site to access.
TOBTOC_SITE_URL:   The TOBTOC_SITE_URL has different urls at different sites, you should always choose the OrderService address of the nearest site to access. 
    
The following describes parameters in subscription_service.php.
TOC_SITE_URL:      The TOC_SITE_URL has different urls at different sites, you should always choose the OrderService address of the nearest site to access.
TOBTOC_SITE_URL:   The TOBTOC_SITE_URL has different urls at different sites, you should always choose the OrderService address of the nearest site to access.

The following describes parameters in event/app_server.php.
PUBLIC_KEY:    RSA public key.
```

## Sample Code

```
Each method in the PHP sample calls an API of the HUAWEI IAP server.
The following describes methods in the PHP sample.

1). AtDemo: getAppAT()
You can call this method to get App Level AccessToken.
Code location   at_demo.php

2). OrderService: verifyToken()
You can call this method to verify the purchase token in the payment result with the Huawei payment server to confirm the accuracy of the payment result.
The URL is {rootUrl}/applications/purchases/tokens/verify. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
Code location?order_service.php

3). OrderService: cancelledListPurchase()
You can call this method to pagination query all purchase information that has been cancelled or has a refund.
The URL is {rootUrl}/applications/{apiVersion}/purchases/cancelledList. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
Code location   order_service.php

4). OrderService: confirmPurchase()
You can call this method to confirm purchased product.
The URL is {rootUrl}/applications/{apiVersion}/purchases/confirm. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
Code location   order_service.php

5). SubscriptionService: getSubscription()
You can call this method to verify a purchased subscription product, such as to obtain the validity period and status。
The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/get. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
Code location   subscription_service.php
    
6). SubscriptionService: stopSubscription()
You can call this method to cancel an already subscribed product, the subscription is still valid during the validity period, and subsequent renewals will be terminated.
The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/stop. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
Code location   subscription_service.php

7). SubscriptionService: delaySubscription()
You can call this method to renew a subscription product for a customer until a specified time in the future. After success, the customer's subscription will expire at a future time.
The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/delay. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
Code location   subscription_service.php

8). SubscriptionService: returnFeeSubscription()
You can call this method to refund the last renewal fee of a subscription product, but the subscription product is still valid during the validity period, and subsequent renewals will be performed normally.
The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/returnFee. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
Code location   subscription_service.php

9). SubscriptionService: withdrawSubscription()
You can call this method to cancel a subscription, which is equivalent to executing the returnFeeSubscription method, and immediately ending the subscription service and subsequent renewal.
The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/withdrawal. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
Code location   subscription_service.php

10). AppServer: dealNotification()
You can call this method to handle subscription event notifications.
The information parameter is obtained from subscription event notification.
Code location   event/app_server.php
```

## License

```
IAP PHP sample is licensed under the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
```

