/*
 * Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 *
 */

using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Net.Security;
using System.Runtime.InteropServices;

namespace IapDemo
{

    public class DemoConfig
    {
        public String clientSecret { get; set; }
        public String clientId { get; set; }
        public String tokenUrl { get; set; }

        public String orderUrl { get; set; }

        public String subscriptionUrl { get; set; }

        public String applicationPublicKey { get; set; }

        public static DemoConfig getDefaultConfig()
        {
            DemoConfig demoConfig = new DemoConfig();
            // your client secret
            demoConfig.clientSecret = "appsecret";
            // your app id
            demoConfig.clientId = "1234567";

            // application public key, base64 encode
            demoConfig.applicationPublicKey = "public key, base64 encode";

            // product token url
            demoConfig.tokenUrl = "https://oauth-login.cloud.huawei.com/oauth2/v3/token";


            return demoConfig;
        }
    }

    public class AtResponse
    {
        public string access_token { get; set; }
    }


    public class AtDemo
    {
        public static String getAppAt()
        {
            var demoConfig = DemoConfig.getDefaultConfig();

            String grant_type = "client_credentials";
            String msgBody = String.Format("grant_type={0}&client_secret={1}&client_id={2}", WebUtility.UrlEncode(grant_type),
                WebUtility.UrlEncode(demoConfig.clientSecret), WebUtility.UrlEncode(demoConfig.clientId));

            String retString = httpPost(demoConfig.tokenUrl, "application/x-www-form-urlencoded", msgBody, 5, null, 0);

            if (retString.IndexOf("access_token") != -1)
            {
                var atResponse = JsonSerializer.Deserialize<AtResponse>(retString);
                return atResponse.access_token;
            }
            else
            {
                System.Console.Error.WriteLine("Get token fail, " + retString);
                throw new System.ArgumentException("Get token fail", retString);
            }
        }

        public static String httpPost(String httpUrl, String contentType, String requestBody, int timeOut, HttpRequestHeaders headers, int enhancedSafety)
        {
            // if your OS is Windows, you cannot specify the Cipher Suites with code, please make sure the local OS configuration support the specified cipher suites and TLS version
            var client = new HttpClient();
            // if your OS is Linux or OSX, you can specify the Cipher Suites like this
            if (enhancedSafety == 1 && !RuntimeInformation.IsOSPlatform(OSPlatform.Windows)) {
                var sslOptions = new SslClientAuthenticationOptions {
                    CipherSuitesPolicy  = new CipherSuitesPolicy(new List<TlsCipherSuite>{ 
                        TlsCipherSuite.TLS_AES_128_GCM_SHA256,
                        TlsCipherSuite.TLS_AES_256_GCM_SHA384,
                        TlsCipherSuite.TLS_CHACHA20_POLY1305_SHA256,
                        TlsCipherSuite.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,
                        TlsCipherSuite.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,
                        TlsCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,
                        TlsCipherSuite.TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,
                    })
                };
                var socketsHttpHandler = new SocketsHttpHandler { SslOptions = sslOptions };
                client = new HttpClient(socketsHttpHandler, true);
            }
            client.Timeout = TimeSpan.FromSeconds(timeOut);

            if (headers != null)
            {
                foreach (var header in headers)
                {
                    client.DefaultRequestHeaders.Add(header.Key, header.Value);
                }
            }

            var httpContent = new StringContent(requestBody, Encoding.UTF8, contentType);

            var repTask = client.PostAsync(httpUrl, httpContent);
            repTask.Wait();
            var resContent = repTask.Result.Content;
            var strTask = resContent.ReadAsStringAsync();
            strTask.Wait();
            var retString = strTask.Result;
            return retString;
        }


        public static HttpRequestHeaders buildAuthorization()
        {
            var appAt = AtDemo.getAppAt();
            var oriString = String.Format("APPAT:{0}", appAt);
            var authString = Convert.ToBase64String(Encoding.UTF8.GetBytes(oriString));
            var authHeaderString = String.Format("Basic {0}", authString);
            HttpRequestHeaders headers = new HttpClient().DefaultRequestHeaders;
            headers.Add(HttpRequestHeader.Authorization.ToString(), authHeaderString);
            return headers;
        }

        public static Boolean verifyRsaSign(String content, String sign, String publicKey, String signatureAlgorithm)
        {
            bool checkRet = false;
            using (var rsaProv = (RSA)RSA.Create())
            {
                byte[] contentBytes = Encoding.UTF8.GetBytes(content);
                byte[] signBytes = Convert.FromBase64String(sign);
                byte[] publicKeyBytes = Convert.FromBase64String(publicKey);
                try
                {
                    int readBytes = 0;
                    rsaProv.ImportSubjectPublicKeyInfo(publicKeyBytes, out readBytes);
                    Console.WriteLine("VerifyData"+signatureAlgorithm);
                    if(signatureAlgorithm.Equals("SHA256WithRSA/PSS"))
                    {
                        checkRet = rsaProv.VerifyData(contentBytes, signBytes, HashAlgorithmName.SHA256, RSASignaturePadding.Pss);
                    }else if (signatureAlgorithm.Equals("SHA256WithRSA"))
                    {
                    checkRet = rsaProv.VerifyData(contentBytes, signBytes, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
                    }
                    
                }
                catch (CryptographicException e)
                {
                    Console.WriteLine(e.Message);
                }
                finally
                {
                    rsaProv.Clear();
                }
            }
            return checkRet;
        }
    }

    public class OrderDemo
    {
        public static String getRootUrl(int accountFlag) {
                if (accountFlag == 1) {
                   // site for telecom carrier
                    return "https://orders-at-dre.iap.cloud.huawei.eu";
                }
                // TODO: replace the (ip:port) to the real one,
                return "https://ip:port";
            }
        public static void verifyToken(String purchaseToken, String productId,int accountFlag)
        {
            var requestHeaders = AtDemo.buildAuthorization();
            Dictionary<string, string> bodyMap = new Dictionary<string, string>();
            bodyMap.Add("purchaseToken", purchaseToken);
            bodyMap.Add("productId", productId);
            var bodyString = JsonSerializer.Serialize(bodyMap);
            String responseString = AtDemo.httpPost(getRootUrl(accountFlag) + "/applications/purchases/tokens/verify", "application/json", bodyString, 5, requestHeaders, 1);

            // TODO: display the response as string in console, you can replace it with your business logic.
            Console.WriteLine(responseString);
        }

        public static void cancelledListPurchase(long endAt, long startAt, int maxRows, int type, string continuationToken,int accountFlag)
        {
            var requestHeaders = AtDemo.buildAuthorization();

            // pack the request body
            Dictionary<string, string> bodyMap = new Dictionary<string, string>();
            bodyMap.Add("endAt", endAt.ToString());
            bodyMap.Add("startAt", startAt.ToString());
            bodyMap.Add("maxRows", maxRows.ToString());
            bodyMap.Add("type", type.ToString());
            bodyMap.Add("continuationToken", continuationToken.ToString());
            var bodyString = JsonSerializer.Serialize(bodyMap);

            String responseString = AtDemo.httpPost(getRootUrl(accountFlag) + "/applications/v2/purchases/cancelledList", "application/json", bodyString, 5, requestHeaders, 1);

            // TODO: display the response as string in console, you can replace it with your business logic.
            Console.WriteLine(responseString);
        }

        public static void confirmPurchase(String purchaseToken, String productId,int accountFlag)
        {
            var requestHeaders = AtDemo.buildAuthorization();

            // pack the request body
            Dictionary<string, string> bodyMap = new Dictionary<string, string>();
            bodyMap.Add("purchaseToken", purchaseToken);
            bodyMap.Add("productId", productId);

            var bodyString = JsonSerializer.Serialize(bodyMap);

            String responseString = AtDemo.httpPost(getRootUrl(accountFlag) + "/applications/v2/purchases/confirm", "application/json", bodyString, 5, requestHeaders, 1);

            // TODO: display the response as string in console, you can replace it with your business logic.
            Console.WriteLine(responseString);
        }
    }

    public class SubscriptionDemo
    {

        public static String getRootUrl(int accountFlag) {
            if ( accountFlag == 1) {
               // site for telecom carrier
                return "https://subscr-at-dre.iap.cloud.huawei.eu";
            }
            // TODO: replace the (ip:port) to the real one,
            return "https://ip:port";
        }
        public static void getSubscription(string subscriptionId, string purchaseToken,int accountFlag)
        {
            var headers = AtDemo.buildAuthorization();

            // pack the request body
            Dictionary<string, string> bodyMap = new Dictionary<string, string>();
            bodyMap.Add("subscriptionId", subscriptionId);
            bodyMap.Add("purchaseToken", purchaseToken);

            var bodyString = JsonSerializer.Serialize(bodyMap);
            var config = DemoConfig.getDefaultConfig();

            String responseString = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/get",
            "application/json", bodyString, 5, headers, 1);

            // TODO: display the response as string in console, you can replace it with your business logic.
            Console.WriteLine(responseString);
        }

        public static void stopSubscription(string subscriptionId, string purchaseToken,int accountFlag)
        {
            var headers = AtDemo.buildAuthorization();

            // pack the request body
            Dictionary<string, string> bodyMap = new Dictionary<string, string>();
            bodyMap.Add("subscriptionId", subscriptionId);
            bodyMap.Add("purchaseToken", purchaseToken);

            var bodyString = JsonSerializer.Serialize(bodyMap);

            String responseString = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/stop",
                "application/json", bodyString, 5, headers, 1);

            // TODO: display the response as string in console, you can replace it with your business logic.
            Console.WriteLine(responseString);
        }

        public static void delaySubscription(string subscriptionId, string purchaseToken, long currentExpirationTime,
            long desiredExpirationTime,int accountFlag)
        {
            var headers = AtDemo.buildAuthorization();

            // pack the request body
            Dictionary<string, string> bodyMap = new Dictionary<string, string>();
            bodyMap.Add("subscriptionId", subscriptionId);
            bodyMap.Add("purchaseToken", purchaseToken);
            bodyMap.Add("currentExpirationTime", currentExpirationTime + "");
            bodyMap.Add("desiredExpirationTime", desiredExpirationTime + "");
            var bodyString = JsonSerializer.Serialize(bodyMap);

            String responseString = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/delay",
            "application/json", bodyString, 5, headers, 1);

            // TODO: display the response as string in console, you can replace it with your business logic.
            Console.WriteLine(responseString);
        }

        public static void returnFeeSubscription(string subscriptionId, string purchaseToken,int accountFlag)
        {
            var headers = AtDemo.buildAuthorization();

            // pack the request body
            Dictionary<string, string> bodyMap = new Dictionary<string, string>();
            bodyMap.Add("subscriptionId", subscriptionId);
            bodyMap.Add("purchaseToken", purchaseToken);

            var bodyString = JsonSerializer.Serialize(bodyMap);

            String responseString = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/returnFee",
            "application/json", bodyString, 5, headers, 1);

            // TODO: display the response as string in console, you can replace it with your business logic.
            Console.WriteLine(responseString);
        }

        public static void withdrawalSubscription(string subscriptionId, string purchaseToken,int accountFlag)
        {
            var headers = AtDemo.buildAuthorization();

            // pack the request body
            Dictionary<string, string> bodyMap = new Dictionary<string, string>();
            bodyMap.Add("subscriptionId", subscriptionId);
            bodyMap.Add("purchaseToken", purchaseToken);

            var bodyString = JsonSerializer.Serialize(bodyMap);

            String responseString = AtDemo.httpPost(getRootUrl(accountFlag) + "/sub/applications/v2/purchases/withdrawal",
                "application/json", bodyString, 5, headers, 1);

            // TODO: display the response as string in console, you can replace it with your business logic.
            Console.WriteLine(responseString);
        }

    }

    public class NotificationRequest
    {
        public string statusUpdateNotification { get; set; }
        public string notifycationSignature { get; set; }
    }

    public class NotificationResponse
    {
        public string ErrorCode { get; set; }
        public string ErrorMsg { get; set; }
    }

    public class StatusUpdateNotification
    {
        public string environment { get; set; }
        public int notificationType { get; set; }
        public string subscriptionId { get; set; }
        public long cancellationDate { get; set; }
        public string orderId { get; set; }
        public string latestReceipt { get; set; }
        public string latestReceiptInfo { get; set; }
        public string latestReceiptInfoSignature { get; set; }
        public string latestExpiredReceipt { get; set; }
        public string latestExpiredReceiptInfo { get; set; }
        public string latestExpiredReceiptInfoSignature { get; set; }
        public long autoRenewStatus { get; set; }
        public string refundPayOrderId { get; set; }
        public string productId { get; set; }
        public string applicationId { get; set; }
        public int expirationIntent { get; set; }
    }

    enum NotificationType : int
    {
        INITIAL_BUY = 0,
        CANCEL = 1,
        RENEWAL = 2,
        INTERACTIVE_RENEWAL = 3,
        NEW_RENEWAL_PREF = 4,
        RENEWAL_STOPPED = 5,
        RENEWAL_RESTORED = 6,
        RENEWAL_RECURRING = 7,
        ON_HOLD = 9,
        PAUSED = 10,
        PAUSE_PLAN_CHANGED = 11,
        PRICE_CHANGE_CONFIRMED = 12,
        DEFERRED = 13,
    }

    public class NotificationDemo
    {
        public static void dealNotification(String information)
        {
            var request = JsonSerializer.Deserialize<NotificationRequest>(information);
            var checkRet = AtDemo.verifyRsaSign(request.statusUpdateNotification, request.notifycationSignature, DemoConfig.getDefaultConfig().applicationPublicKey, "SHA256WithRSA");
            if (!checkRet)
            {
                Console.WriteLine("rsa sign check fail");
                return;
            }

            var info = JsonSerializer.Deserialize<StatusUpdateNotification>(request.statusUpdateNotification);
            var notificationType = (NotificationType)info.notificationType;
            switch (notificationType)
            {
                case NotificationType.INITIAL_BUY:
                    break;
                case NotificationType.CANCEL:
                    break;
                case NotificationType.RENEWAL:
                    break;
                case NotificationType.INTERACTIVE_RENEWAL:
                    break;
                case NotificationType.NEW_RENEWAL_PREF:
                    break;
                case NotificationType.RENEWAL_STOPPED:
                    break;
                case NotificationType.RENEWAL_RESTORED:
                    break;
                case NotificationType.RENEWAL_RECURRING:
                    break;
                case NotificationType.ON_HOLD:
                    break;
                case NotificationType.PAUSED:
                    break;
                case NotificationType.PAUSE_PLAN_CHANGED:
                    break;
                case NotificationType.PRICE_CHANGE_CONFIRMED:
                    break;
                case NotificationType.DEFERRED:
                    break;
                default:
                    break;
            }
        }
    }



    public class Demo
    {

        static void Main(string[] args)
        {
            var at = AtDemo.getAppAt();
            Console.Out.WriteLine(at);

            OrderDemo.verifyToken("demoToken", "demoProductId", 0);

            OrderDemo.cancelledListPurchase(123, 456, 100, 0, "demoToken", 0);

            OrderDemo.confirmPurchase("demoToken", "demoProductId", 0);

            SubscriptionDemo.getSubscription("demoId", "demoToken", 0);

            SubscriptionDemo.stopSubscription("demoId", "demoToken", 0);

            SubscriptionDemo.delaySubscription("demoId", "demoToken", 123, 456, 0);

            SubscriptionDemo.returnFeeSubscription("demoId", "demoToken", 0);

            SubscriptionDemo.withdrawalSubscription("demoId", "demoToken", 0);
        }
    }

}
