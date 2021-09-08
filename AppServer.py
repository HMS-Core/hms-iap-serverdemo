# Copyright 2020. Huawei Technologies Co., Ltd. All rights reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
"""
Demo service to do IAP notification check.
"""
import json
from json import JSONDecodeError
import RSAUtil


class AppServer:
    """IAP notification check"""
    INITIAL_BUY = 0
    CANCEL = 1
    RENEWAL = 2
    INTERACTIVE_RENEWAL = 3
    NEW_RENEWAL_PREF = 4
    RENEWAL_STOPPED = 5
    RENEWAL_RESTORED = 6
    RENEWAL_RECURRING = 7
    ON_HOLD = 9
    PAUSED = 10
    PAUSE_PLAN_CHANGED = 11
    PRICE_CHANGE_CONFIRMED = 12
    DEFERRED = 13

    def __init__(self):
        self.publicKey = "the public key"

    def dealNotification(self, raw_post_data):
        try:
            jsonObject = json.loads(raw_post_data)
            request = StatusUpdateNotificationRequest()
            request.statusUpdateNotification = jsonObject['statusUpdateNotification']
            request.notifycationSignature = jsonObject['notifycationSignature']
            if request.statusUpdateNotification is None or request.notifycationSignature is None:
                print('the notification message is empty')
                return
            # verify the notification
            result = RSAUtil.verify(self.publicKey, request.statusUpdateNotification, request.notifycationSignature)
            if not result:
                return
            # TODO replace with your logic
            statusUpdateNotification = json.loads(request.statusUpdateNotification)
            notificationType = statusUpdateNotification['notificationType']
            if notificationType == self.INITIAL_BUY:
                pass
            elif notificationType == self.CANCEL:
                pass
            elif notificationType == self.RENEWAL:
                pass
            elif notificationType == self.INTERACTIVE_RENEWAL:
                pass
            elif notificationType == self.NEW_RENEWAL_PREF:
                pass
            elif notificationType == self.RENEWAL_STOPPED:
                pass
            elif notificationType == self.RENEWAL_RESTORED:
                pass
            elif notificationType == self.RENEWAL_RECURRING:
                pass
            elif notificationType == self.ON_HOLD:
                pass
            elif notificationType == self.PAUSED:
                pass
            elif notificationType == self.PAUSE_PLAN_CHANGED:
                pass
            elif notificationType == self.PRICE_CHANGE_CONFIRMED:
                pass
            elif notificationType == self.DEFERRED:
                pass
        except (JSONDecodeError, TypeError) as e:
            print('error: %s' % e)


class StatusUpdateNotificationRequest:
    statusUpdateNotification = None
    notifycationSignature = None

    def __init__(self):
        self.statusUpdateNotification = None
        self.notifycationSignature = None
