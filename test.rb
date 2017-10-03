require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/hello-monkey' do

  Twilio::TwiML::VoiceResponse.new do |r|
    r.say("Hello Cooper")
    r.pause(length: 2)
    r.play(digits: "5")
    r.say("start your message")
    r.record(action: 'http://court-tracker.herokuapp.com/voice_messages', method: 'post', finish_on_key: '*')
  end.to_s
end

get '/record-it' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.say('Listen to your message.')
    r.say('Goodbye.')
  end.to_s
end

