require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/hello-monkey' do

  Twilio::TwiML::VoiceResponse.new do |r|
    r.say("Hello Cooper")
    r.pause(length: 5)
    r.play(digits: "5")
    r.say("start your message")
    r.record(timeout: 15, transcribe: true, action: 'http://foo.edu/handleRecording.php', finish_on_key: '*')
  end.to_s

end
