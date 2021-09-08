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

require 'json'
require_relative 'rsa_check'
require_relative 'notification_type'
class AppServer

  # the public key
  PUBLIC_KEY = 'the public key'
  ERROR_CODE = 'ErrorCode'
  ERROR_MSG = 'ErrorMsg'
  NOTIFICATION_SIGNATURE = 'notifycationSignature'
  STATUS_UPDATE_NOTIFICATION = 'statusUpdateNotification'

  def dealNotification(information)
    if (!information)
      return
    end

    request = JSON.parse(information)
    response = Hash.new;

    if (!request[NOTIFICATION_SIGNATURE] || !request[STATUS_UPDATE_NOTIFICATION])
      puts 'rsp signature or status update is null'
      # failure, the response set by yourself
      response[ERROR_CODE] = 1;
      response[ERROR_MSG] = 'the notification message is empty'
      return response.to_json
    end

    # verify the notification
    rsaCheck = RsaCheck.new
    isCheckOk = rsaCheck.check(request[STATUS_UPDATE_NOTIFICATION], request[NOTIFICATION_SIGNATURE], PUBLIC_KEY)
    if (!isCheckOk)
      puts 'signature RSA check failure'
      # failure, the response set by yourself
      response[ERROR_CODE] = 2
      response[ERROR_MSG] = 'verify the sign failure'
      return response.to_json
    end

    statusUpdateNotification = JSON.parse(request[STATUS_UPDATE_NOTIFICATION])

    # TODO replace with your business logic
    case statusUpdateNotification['notificationType']
    when NOTIFICATION_TYPE::INITIAL_BUY
      puts 'initial buy'
    when NOTIFICATION_TYPE::INTERACTIVE_RENEWAL
      puts 'interactive renewal'
    when NOTIFICATION_TYPE::PRICE_CHANGE_CONFIRMED
      puts 'price change confirmed'
    when NOTIFICATION_TYPE::CANCEL
      puts 'cancel'
    else
      puts 'default'
    end
  end
end