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
require 'OpenSSL'
require 'Base64'

class RsaCheck

  def check(content, sign, public)
    if (!content || !sign || !public)
      return
    end
    key = OpenSSL::PKey::RSA.new(Base64.decode64(public))
    digester = OpenSSL::Digest::SHA256.new
    return key.verify(digester, Base64.decode64(sign), content)
  end
end