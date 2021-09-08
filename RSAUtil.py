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
RSA tools
"""
from base64 import b64decode

from Cryptodome.Hash import SHA256
from Cryptodome.PublicKey import RSA
from Cryptodome.Signature import PKCS1_v1_5


def verify(public_key, origin_data, signature):
    """ verify sign """
    key_bytes = bytes(public_key, encoding="utf-8")
    key_bytes = b64decode(key_bytes)
    key = RSA.importKey(key_bytes)
    hash_value = SHA256.new(bytes(origin_data, encoding="utf-8"))
    verifier = PKCS1_v1_5.new(key)
    if verifier.verify(hash_value, b64decode(signature)):
        print("verify the sign success.")
        return True
    else:
        print("verify the sign failure.")
        return False
