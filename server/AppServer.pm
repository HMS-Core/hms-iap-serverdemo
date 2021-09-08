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
package server::AppServer;
##################################################
#   AtDemo.
##################################################
use strict;
use warnings;
use lib "..";
use JSON::Parse 'parse_json';
use Switch;
use util::RsaChecker;
use Data::Dumper;

use constant {
  #The constant INITIAL_BUY.
  'INITIAL_BUY' => 0,
  #The constant CANCEL.
  'CANCEL' => 1,
  # The constant RENEWAL.
  'RENEWAL' => 2,
  #The constant INTERACTIVE_RENEWAL.
  'INTERACTIVE_RENEWAL' => 3,
  #The constant NEW_RENEWAL_PREF.
  'NEW_RENEWAL_PREF' => 4,
  # The constant RENEWAL_STOPPED.
  'RENEWAL_STOPPED' => 5,
  #The constant RENEWAL_RESTORED.
  'RENEWAL_RESTORED' => 6,
  # The constant RENEWAL_RECURRING.
  'RENEWAL_RECURRING' => 7,
  # The constant ON_HOLD.
  'ON_HOLD' => 9,
  #The constant PAUSED.
  'PAUSED' => 10,
  #The constant PAUSE_PLAN_CHANGED.
  'PAUSE_PLAN_CHANGED' => 11,
  #The constant PRICE_CHANGE_CONFIRMED.
  'PRICE_CHANGE_CONFIRMED' => 12,
  # The constant DEFERRED.
  'DEFERRED' => 13
};

sub dealNotification {
  my $information = $_[0];
  # TODO: public key
  my $PUBLIC_KEY = "_public_key_";
  my $ERROR_CODE = 'errorCode';
  my $ERROR_MSG = 'errorMsg';
  my $NOTIFICATION_SIGNATURE = 'notifycationSignature';
  my $STATUS_UPDATE_NOTIFICATION = 'statusUpdateNotification';

  die "parameter invalid" unless defined($information);
  my $request = parse_json($information);
  my %response = ();
  if (!defined($request->{$NOTIFICATION_SIGNATURE}) || (!defined($request->{$STATUS_UPDATE_NOTIFICATION}))) {
    $response{$ERROR_CODE} = 1;
    $response{$ERROR_MSG} = 'the notification message is empty';
    return \%response;
  }
  my $valid = util::RsaChecker::check($request->{$STATUS_UPDATE_NOTIFICATION}, $request->{$NOTIFICATION_SIGNATURE}, $PUBLIC_KEY);
  print "\n-----------------------\n";
  print Dumper($valid);
  print "\n-----------------------\n";
  if (!$valid) {
    print "signature is invalid\n";
    $response{$ERROR_CODE} = 2;
    $response{$ERROR_MSG} = 'signature is invalid';
    return \%response;
  }

  my $statusUpdateNotification = parse_json($request->{$STATUS_UPDATE_NOTIFICATION});

  my $notificationType = $statusUpdateNotification->{notificationType};
  switch($notificationType) {
    case INITIAL_BUY {print "INITIAL_BUY\n"}

    case INTERACTIVE_RENEWAL {print "INTERACTIVE_RENEWAL\n"}

    case PRICE_CHANGE_CONFIRMED {print "PRICE_CHANGE_CONFIRMED\n"}

    case CANCEL {print "CANCEL\n"}

    else {print "failed\n"}
  }

  $response{$ERROR_CODE} = 0;
  $response{$ERROR_MSG} = 'success';

  return \%response;
}

1;
__END__