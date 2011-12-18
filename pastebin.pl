#!/usr/bin/perl
use strict;
use warnings;
use URI::Escape;

my %opts = (
	api_option        => "paste",
	api_dev_key       => `cat .pastebin_dev_key`,
	api_paste_private => (shift @ARGV // 1), # unless otherwise defined, private paste
	#api_username      => '',
	#api_user_password => '',
	api_paste_code    => uri_escape(join '', <STDIN>),
);

my $poststring = '';

$poststring .= "&$_=$opts{$_}" for(keys %opts);

my $v = `curl -silent -d 'api_option=paste$poststring' pastebin.com/api/api_post.php`;
$v =~ /\r\n\r\n(.*?)$/;
warn $1."\n";