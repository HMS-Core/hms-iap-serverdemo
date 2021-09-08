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
package service::OrderService;
##################################################
#   OrderService.
##################################################
use lib "..";
use strict;
use warnings;
use AtDemo;
use Data::Dumper;

# TODO: replace the (ip:port) to the real one, and if the protocol is https, you should deal with the license
# yourself
my $toc_site_url = "http://ip:port";
# site for telecom carrier
my $tobtoc_site_url = "https://orders-at-dre.iap.dbankcloud.com";

sub getRootUrl {
  print "getRootUrl\n";
  my $accountFlag = $_[0];
  if (defined($accountFlag) && $accountFlag == 1) {
    return $tobtoc_site_url;
  }
  return $toc_site_url;
}

sub verifyToken {
  print "verifyToken\n";
  my $purchaseToken = $_[0];
  my $productId = $_[1];
  my $accountFlag = $_[2];
  my $root_url = getRootUrl($accountFlag);
  my $res = AtDemo::authPost("$root_url/applications/purchases/tokens/verify", [
    purchaseToken => $purchaseToken,
    productId => $productId
  ], 5000, [
    "Content-Type" => "application/json; charset=UTF-8"
  ]);
  print Dumper($res);
}

sub cancelledListPurchase {
  print "cancelledListPurchase\n";
  my $endAt = $_[0];
  my $startAt = $_[1];
  my $maxRows = $_[2];
  my $type = $_[3];
  my $continuationToken = $_[4];
  my $accountFlag = $_[5];
  my $root_url = getRootUrl($accountFlag);
  my $res = AtDemo::authPost("$root_url/applications/v2/purchases/cancelledList", [
    endAt => $endAt,
    startAt => $startAt,
    maxRows => $maxRows,
    type => $type,
    continuationToken => $continuationToken
  ], 5000, [
    "Content-Type" => "application/json; charset=UTF-8"
  ]);
  print Dumper($res);
}

sub confirmPurchase {
  print "verifyToken\n";
  my $purchaseToken = $_[0];
  my $productId = $_[1];
  my $accountFlag = $_[2];
  my $root_url = getRootUrl($accountFlag);
  my $res = AtDemo::authPost("$root_url/applications/v2/purchases/confirm", [
    purchaseToken => $purchaseToken,
    productId => $productId
  ], 5000, [
    "Content-Type" => "application/json; charset=UTF-8"
  ]);
  print Dumper($res);
}

1;
__END__