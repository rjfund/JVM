require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/' do
  'Hello World! Currently running version ' + Twilio::VERSION + \
    ' of the twilio-ruby library.'
end

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
  end.to_s

end
