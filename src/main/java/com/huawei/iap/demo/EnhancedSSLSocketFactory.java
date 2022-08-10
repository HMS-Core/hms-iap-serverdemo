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

package com.huawei.iap.demo;

import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;

import javax.net.ssl.SSLSocket;
import javax.net.ssl.SSLSocketFactory;

/**
 * 增强的SSL Socket工厂
 *
 * @author iap
 * @since 2022-08-04
 */
public class EnhancedSSLSocketFactory extends SSLSocketFactory {
    private final SSLSocketFactory sf;

    private final String[] protocolList;

    private final String[] cipherList;

    public EnhancedSSLSocketFactory(SSLSocketFactory sf, String[] protocolList, String[] cipherList) {
        this.sf = sf;
        this.protocolList = protocolList;
        this.cipherList = cipherList;
    }

    @Override
    public String[] getDefaultCipherSuites() {
        return sf.getDefaultCipherSuites();
    }

    @Override
    public String[] getSupportedCipherSuites() {
        return sf.getSupportedCipherSuites();
    }

    @Override
    public Socket createSocket(Socket socket, String s, int i, boolean b) throws IOException {
        return wrapSocket(sf.createSocket(socket, s, i, b));
    }

    @Override
    public Socket createSocket(String s, int i) throws IOException, UnknownHostException {
        return wrapSocket(sf.createSocket(s, i));
    }

    @Override
    public Socket createSocket(String s, int i, InetAddress inetAddress, int i1)
        throws IOException, UnknownHostException {
        return wrapSocket(sf.createSocket(s, i, inetAddress, i1));
    }

    @Override
    public Socket createSocket(InetAddress inetAddress, int i) throws IOException {
        return wrapSocket(sf.createSocket(inetAddress, i));
    }

    @Override
    public Socket createSocket(InetAddress inetAddress, int i, InetAddress inetAddress1, int i1) throws IOException {
        return wrapSocket(sf.createSocket(inetAddress, i, inetAddress1, i1));
    }

    private Socket wrapSocket(Socket socket) {
        if (!(socket instanceof SSLSocket)) {
            return socket;
        }
        SSLSocket sslSocket = (SSLSocket) socket;
        if (cipherList != null && cipherList.length > 0) {
            sslSocket.setEnabledCipherSuites(cipherList);
        }
        if (protocolList != null && protocolList.length > 0) {
            sslSocket.setEnabledProtocols(protocolList);
        }
        return sslSocket;
    }
}
