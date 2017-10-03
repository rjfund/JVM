require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/hello-monkey' do

  Twilio::TwiML::VoiceResponse.new do |r|
    r.say("Hello Cooper")
    r.pause(length: 5)
    r.play(digits: "5555")
    r.say("I played five five times")
  end.to_s

end
