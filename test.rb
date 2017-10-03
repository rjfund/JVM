require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/' do
  'Hello World! Currently running version ' + Twilio::VERSION + \
    ' of the twilio-ruby library.'
end

get '/hello-monkey' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.say 'Hello Monkey'
  end.to_s
end
