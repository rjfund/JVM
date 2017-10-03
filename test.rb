require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/hello-monkey' do
  people = {
    '+17078476844' => 'Cooper Mayne',
    '+14158675310' => 'Boots',
    '+14158675311' => 'Virgil',
    '+14158675312' => 'Marcel',
  }

  name = people[params['From']] || 'Monkey'

  Twilio::TwiML::VoiceResponse.new do |r|
    r.say("Hello #{name}")
    r.play(url: "http://demo.twilio.com/hellomonkey/monkey.mp3")
  end.to_s

end
