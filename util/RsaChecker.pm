=license
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
=cut
package util::RsaChecker;
##################################################
#   RsaChecker.
##################################################
use strict;
use warnings;
use MIME::Base64;
use Crypt::OpenSSL::RSA;
use Data::Dumper;

sub check {
  my $content = $_[0];
  my $sign = $_[1];
  my $public = $_[2];
  die "parameter invalid" unless defined($content);
  die "parameter invalid" unless defined($sign);
  die "parameter invalid" unless defined($public);

  my @strlist = ($public =~ m/.{64}|.{1,64}$/g);
  my $joinstr = join("\n", @strlist);
  my $pubKey_wrapped = qq~-----BEGIN PUBLIC KEY-----
$joinstr
-----END PUBLIC KEY-----
~;

  my $rsa = Crypt::OpenSSL::RSA->new_public_key($pubKey_wrapped);
  $rsa->use_sha256_hash();
  if ($rsa->verify($content, decode_base64($sign))) {
    return 1;
  } else {
    return 0;
  }
}

1;
__END__