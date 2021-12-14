# **iap-java-sample**

English | [中文](README_ZH.md)

## Contents

 * [Introduction](#introduction)
 * [Installation](#installation)
 * [Environment Requirements](#Environment Requirements)
 * [Configuration ](#configuration )
 * [Sample Code](#Sample Code)
 * [License](#license)


## Introduction
Java sample code encapsulates APIs of the HUAWEI IAP server. It provides many sample programs for your reference or use.
The following describes packages of Java sample code.

**AtDemo:** Sample code of **AccessToken**. Each method can run independently.
**OrderService:** Sample code of **OrderService**. Each method can run independently.
**SubscriptionService:** Sample code of **SubscriptionService**. Each method can run independently.
**notification:** Sample code of **notification**. Each method can run independently.

## Installation
Before using Java sample code, check whether the Java environment has been installed. 
Decompress the Java sample code package.

Copy the Java sample code package in the decompressed folder to the project vendor directory in the path specified by **JAVAPATH**.
Refresh the project and ensure that the file is successfully copied to the destination directory.

## Environment Requirements
JDK 1.8 or a later version is recommended.    

## Configuration
To use functions provided in examples, you need to set related parameters in **AtDemo.java**, **OrderService.java**, **SubscriptionService.java**, and **AppServer.java** in the package.

The following describes parameters in **AtDemo.java**.
**clientId:** Client ID, which is obtained from app information.
**clientSecret:** Secret access key of an app, which is obtained from app information.
**tokenUrl:** URL for the Huawei OAuth 2.0 service to obtain a token. Please refer to [OAuth 2.0-based Authentication](https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides/open-platform-oauth-0000001053629189?ha_source=hms1).
    
The following describes parameters in **notification/AppServer.java**.
**PUBLIC_KEY:** RSA public key.

At first, the meaning of **accountFlag** should be clear. If field **accountFlag** in **InappPurchaseData** equals to **1**, the account belongs to telecom carrier (**TOBTOC_SITE_URL**); otherwise, to Huawei (**TOC_SITE_URL**).  
For both **OrderService** and **SubscriptionService**, you need to choose appropriate site.
**TOC_SITE_URL:** The TOC_SITE_URL has different URLs at different sites, you should always choose the address of the nearest site to access.
**TOBTOC_SITE_URL:** The site for telecom carrier.

## Sample Code
Each method in the Java sample calls an API of the HUAWEI IAP server.
The following describes methods in the Java sample.



1. AtDemo: getAppAT()

   You can call this method to get an app-level Access Token.
   Code location: **src/main/java/com/example/demo/AtDemo.java**



2. OrderService: verifyToken()

   You can call this method to verify the purchase token in the payment result with the Huawei payment server to confirm the accuracy of the payment result.
   The URL is **{rootUrl}/applications/purchases/tokens/verify**. The rootUrl has different URLs at different sites, you should always choose the Order service address of the nearest site to access.
   Code location: **src/main/java/com/example/demo/OrderService.java**
       

3. OrderService: cancelledListPurchase()

   You can call this method to pagination query all purchase information that has been cancelled or has a refund.
   The URL is **{rootUrl}/applications/{apiVersion}/purchases/cancelledList**. The rootUrl has different URLs at different sites, you should always choose the Order service address of the nearest site to access.
   Code location: **src/main/java/com/example/demo/OrderService.java**
       

4. SubscriptionService: getSubscription()

   You can call this method to verify a purchased subscription product, such as to obtain the validity period and status.
   The URL is **{rootUrl}/sub/applications/{apiVersion}/purchases/get**. The rootUrl has different URLs at different sites, you should always choose the Subscription service address of the nearest site to access.
   Code location: **src/main/java/com/example/demo/SubscriptionService.java**
           

5. SubscriptionService: stopSubscription()

   You can call this method to cancel an already subscribed product, the subscription is still valid during the validity period, and subsequent renewals will be terminated.
   The URL is **{rootUrl}/sub/applications/{apiVersion}/purchases/stop**. The rootUrl has different URLs at different sites, you should always choose the Subscription service address of the nearest site to access.
   Code location: **src/main/java/com/example/demo/SubscriptionService.java**
       

6. SubscriptionService: delaySubscription()

   You can call this method to renew a subscription product for a customer until a specified time in the future. After success, the customer's subscription will expire at a future time.
   The URL is **{rootUrl}/sub/applications/{apiVersion}/purchases/delay**. The rootUrl has different URLs at different sites, you should always choose the Subscription service address of the nearest site to access.
   Code location: **src/main/java/com/example/demo/SubscriptionService.java**



7. SubscriptionService: returnFeeSubscription()

   You can call this method to refund the last renewal fee of a subscription product, but the subscription product is still valid during the validity period, and subsequent renewals will be performed normally.
   The URL is **{rootUrl}/sub/applications/{apiVersion}/purchases/returnFee**. The rootUrl has different URLs at different sites, you should always choose the Subscription service address of the nearest site to access.
   Code location: **src/main/java/com/example/demo/SubscriptionService.java**
       

8. SubscriptionService: withdrawSubscription()

   You can call this method to cancel a subscription, which is equivalent to executing the returnFeeSubscription method, and immediately ending the subscription service and subsequent renewal.
   The URL is **{rootUrl}/sub/applications/{apiVersion}/purchases/withdrawal**. The rootUrl has different URLs at different sites, you should always choose the Subscription service address of the nearest site to access.
   Code location: **src/main/java/com/example/demo/SubscriptionService.java**

9. AppServer: dealNotification()

   You can call this method to handle subscription event notifications.
   The information parameter is obtained from subscription event notification.
   Code location: **src/main/java/com/example/demo/notification/AppServer.java**

10. OrderService: confirmPurchase()

    You can call this method to confirm purchase after sending out product.
    The URL is **{rootUrl}/applications/{apiVersion}/purchases/confirm**. The rootUrl has different URLs at different sites, you should always choose the Order service address of the nearest site to access.
    Code location: **OrderService.java**

##  License
IAP Java sample is licensed under [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

