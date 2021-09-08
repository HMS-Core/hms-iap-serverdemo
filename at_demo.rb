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
require 'URI'
require 'net/https'
require 'json'
require 'Base64'
class AtDemo

  # TODO: The values of (clientId, clientSecret, TokenUrl) should be replaced with the actual one.
  # token url to get the authorization
  TOKEN_URL = 'https://oauth-login.cloud.huawei.com/oauth2/v3/token'
  # your client secret
  CLIENT_SECRET = '123'
  # the client id is your APP ID
  CLIENT_ID = '123'

  #  Gets App Level AccessToken
  def getAppAt()
    grantType = "client_credentials";
    headers = {'content-type' => 'application/x-www-form-urlencoded; charset=UTF-8'}
    data = URI.encode_www_form('grant_type' => grantType,
                               'client_secret' => URI::encode(CLIENT_SECRET),
                               'client_id' => CLIENT_ID)

    response = httpsPost(TOKEN_URL, headers, data)
    return JSON.parse(response.body)['access_token']
  end

  # Http post function
  def httpsPost(httpUrl, headers, data)
    url = URI(httpUrl)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    return http.post(url, data, headers)
  end

  # Https post function
  def httpPost(httpUrl, headers, data)
    url = URI(httpUrl)
    http = Net::HTTP.new(url.host, url.port)
    return http.post(url, data, headers)
  end

  # Build Authorization in Header
  def buildAuthorization(appAt)

    prefixAt = 'APPAT:%s' % appAt
    authorization = 'Basic %s' % Base64.strict_encode64(prefixAt)
    headers = Hash.new
    headers['Authorization'] = authorization
    headers['Content-Type'] = 'application/json; charset=UTF-8'
    return headers
  end
end