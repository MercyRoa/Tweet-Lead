#!/usr/bin/env ruby

require 'rubygems'
require 'twitter'
require 'oauth'

consumer_key = 'IrEzCRESTQxBX9BJfgalQ'
consumer_secret = 'uH0aNaJ2pmH3tCg3CaAcRlxYfy238IwIS7Gd1tsJ4'

oauth_consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
                                     :site => 'http://api.twitter.com',
                                     :request_endpoint => 'http://api.twitter.com',
                                     :sign_in => true)

request_token = oauth_consumer.get_request_token
rtoken  = request_token.token
rsecret = request_token.secret

puts "Now visit the following URL:"
puts request_token.authorize_url

print "What was the PIN twitter provided you with? "
pin = gets.chomp

begin
  OAuth::RequestToken.new(oauth_consumer, rtoken, rsecret)
  access_token = request_token.get_access_token(:oauth_verifier => pin)

  puts "oauth_token: " + access_token.token
  puts "oauth_token_secret: " + access_token.secret

  Twitter.configure do |config|
    config.consumer_key = consumer_key
    config.consumer_secret = consumer_secret
    config.oauth_token = access_token.token
    config.oauth_token_secret = access_token.secret
  end

  Twitter::Client.new.verify_credentials
rescue Twitter::Unauthorized
  puts "> FAIL!"
end