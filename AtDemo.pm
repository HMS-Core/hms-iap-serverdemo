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
package AtDemo;
##################################################
#   AtDemo.
##################################################
use strict;
use warnings;
use LWP::UserAgent;
use LWP::Protocol::https;
use HTTP::Request::Common;
use MIME::Base64;
use Data::Dumper;
use JSON::Parse 'parse_json';
use JSON;

my $authToken = '';

sub getAppAT {
    print "getAppAT\n";
    my $client_secret = "appsecret"; # TODO: your client secret
    my $client_id = "1234567"; # TODO: your app Id
    my $tokenUrl = "https://oauth-login.cloud.huawei.com/oauth2/v3/token"; # TODO: token url to get the authorization

    my $grant_type = "client_credentials";
    my $query_body = [
        grant_type => $grant_type,
        client_secret => $client_secret,
        client_id => $client_id
    ];
    my @headers = (
        "Content-Type" => "application/x-www-form-urlencoded; charset=UTF-8"
    );
    my $res = httpPost($tokenUrl, $query_body, 5000, 0, @headers);
    if ($res->is_success) {
        my $body = $res->decoded_content;
        my $json = parse_json($body);
        $authToken = $json->{access_token};
        die "accessToken fetch failed" unless defined($authToken);
    } else {
        print 'error occurred';
        print Dumper($res);
        $authToken = '';
        die "accessToken fetch failed";
    }
}

sub buildAuthorization {
    print "buildAuthorization\n";
    my $appAt = $_[0];
    my $oriString = "APPAT:$appAt";
    my $base64Str = encode_base64($oriString);
    my $authorization = "Basic $base64Str";
    return $authorization
}

sub httpPost {
    print "httpPost\n";
    my ($httpUrl, $data, $timeout, $enhancedSafety, @headers) = @_;
    my $ua = LWP::UserAgent->new(timeout => $timeout);
    if ($enhancedSafety == 1) {
        print "enhancedSafety\n";
        $ua = LWP::UserAgent->new(
            timeout => $timeout,
            ssl_opts => {
                SSL_version => 'TLSv1_2',
                SSL_cipher_list => 'ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256',
                SSL_ciphersuites => 'TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256'
            }
        );
    }
    return $ua->request(POST $httpUrl, @headers, Content => $data);
}

sub authPost {
    print "authPost\n";
    my ($httpUrl, $dataOri, $timeout, $headersOri, $retryTag) = @_;
    if ($authToken eq '') {
        getAppAT();
    }
    my %data = @{$dataOri};
    my $data = encode_json \%data;
    my %headers = @{$headersOri};
    my @headers = ();
    push @headers, (Authorization => buildAuthorization($authToken));
    push @headers, %headers;
    my $res = httpPost($httpUrl, $data, $timeout, 1, @headers);
    if ($res->is_success) {
        my $body = $res->decoded_content;
        my $json = parse_json($body);
        return $json;
    } elsif ($res->code == 401) {
        print "token expired\n";
        $authToken = '';
        if (defined($retryTag)) {
            print Dumper($res);
            die "request failed, you may want to dump the result";
        }
        print "refetch AT and try again\n";
        return authPost($httpUrl, $dataOri, $timeout, $headersOri, 1);
    } else {
        die "request failed, you may want to dump the result";
    }
}

1;
__END__