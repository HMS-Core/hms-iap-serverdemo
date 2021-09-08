## iap-perl-sample


## Table of Contents

 * [Introduction](#introduction)
 * [Installation](#installation)
 * [Configuration ](#configuration )
 * [Supported Environments](#supported-environments)
 * [Sample Code](#Sample Code)
 * [License](#license)


## Introduction
    Perl sample code encapsulates APIs of the HUAWEI IAP server. It provides many sample programs for your reference or usage.
    The following describes packages of perl sample code.

    AtDemo:               Sample code of AccessToken. Each method can run independently.
    service/OrderService:         Sample code of OrderService. Each method can run independently.
    service/SubscriptionService:  Sample code of SubscriptionService. Each method can run independently.
    server/AppServer:     Sample code of dealing with the IAP notification, depends on rsa_sha256.

## Installation
    Before using perl sample code, check whether the perl environment has been installed.
    Install libs: cpan install <lib>.
    the list of libs is:
    JSON/Switch/Data::Dumper/MIME::Base64/Crypt::OpenSSL::RSA/LWP::UserAgent/HTTP::Request::Common/LWP::Protocol::https
    Decompress the perl sample code package.

    Copy the perl sample package in the decompressed folder to the project vendor directory in the path you want.
    Refresh the project and ensure that the file is successfully copied to the destination directory.

## Supported Environments
	Perl 5+ .

## Configuration
    To use functions provided in examples, you need to set related parameters in AtDemo.py, OrderService.py and SubscriptionService.py in the package.

    The following describes parameters in AtDemo.py.
    clientId:      Client ID, which is obtained from app information.
    clientSecret:  Secret access key of an app, which is obtained from app information.
    tokenUrl:      URL for the Huawei OAuth 2.0 service to obtain a token, please refer to Generating an App-Level Access Token.

    The following describes parameters in OrderService.py.
    toc_site_url:      The toc_site_url has different urls at different sites, you should always choose the OrderService address of the nearest site to access.
    tobtoc_site_url:   The tobtoc_site_url has different urls at different sites, you should always choose the OrderService address of the nearest site to access.

    The following describes parameters in SubscriptionService.py.
    toc_site_url:      The toc_site_url has different urls at different sites, you should always choose the OrderService address of the nearest site to access.
    tobtoc_site_url:   The tobtoc_site_url has different urls at different sites, you should always choose the OrderService address of the nearest site to access.

## Sample Code
    Each method in the Perl sample calls an API of the HUAWEI IAP server.
    The following describes methods in the Perl sample.

    1). AtDemo::getAppAT()
    You can call this method to get App Level AccessToken.
    Code location   AtDemo.pm

    2). service::OrderService::verifyToken()
    You can call this method to verify the purchase token in the payment result with the Huawei payment server to confirm the accuracy of the payment result.
    The URL is {rootUrl}/applications/purchases/tokens/verify. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location   service/OrderService.pm

    3). service::OrderService::cancelledListPurchase()
    You can call this method to pagination query all purchase information that has been cancelled or has a refund.
    The URL is {rootUrl}/applications/{apiVersion}/purchases/cancelledList. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location   service/OrderService.pm

    4). service::OrderService::confirmPurchase()
    You can call this method to confirm the purchase information.
    The URL is {rootUrl}/applications/{apiVersion}/purchases/confirm. The rootUrl has different urls at different sites, you should always choose the Order service address of the nearest site to access.
    Code location   service/OrderService.pm

    5). service::SubscriptionService::getSubscription()
    You can call this method to verify a purchased subscription product, such as to obtain the validity period and status。
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/get. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location   service/SubscriptionService.pm

    6). service::SubscriptionService::stopSubscription()
    You can call this method to cancel an already subscribed product, the subscription is still valid during the validity period, and subsequent renewals will be terminated.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/stop. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location   service/SubscriptionService.pm

    7). service::SubscriptionService::delaySubscription()
    You can call this method to renew a subscription product for a customer until a specified time in the future. After success, the customer's subscription will expire at a future time.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/delay. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location   service/SubscriptionService.pm

    8). service::SubscriptionService::returnFeeSubscription()
    You can call this method to refund the last renewal fee of a subscription product, but the subscription product is still valid during the validity period, and subsequent renewals will be performed normally.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/returnFee. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location   service/SubscriptionService.pm

    9). service::SubscriptionService::withdrawSubscription()
    You can call this method to cancel a subscription, which is equivalent to executing the returnFeeSubscription method, and immediately ending the subscription service and subsequent renewal.
    The URL is {rootUrl}/sub/applications/{apiVersion}/purchases/withdrawal. The rootUrl has different urls at different sites, you should always choose the Subscription service address of the nearest site to access.
    Code location   service/SubscriptionService.pm

##  License
    IAP Perl sample is licensed under the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0).

