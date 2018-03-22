require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'pry'


# IMPORTANT:  24 seconds till you have to press 5

get '/hello-monkey' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.say("hello")
    #r.pause(length: 25)
    r.pause(length: 5)
    r.play(digits: "5")
    r.pause(length: 2)
    r.say("This is the voicemail box for Peter Borenstein. Start your message after the tone.")
    r.pause(length: 1)
    r.record(action: 'http://court-tracker.herokuapp.com/voice_messages', method: 'post', finish_on_key: '*')
  end.to_s
end

get '/record-it' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.say 'Listen to your message.'
    r.say 'Goodbye.'
  end.to_s
end

#--------------------------------------------------
#--------------------------------------------------
#--------------------------------------------------
# TEST SERVER WITH --  cd ~/desktop && ./ngrok http 4567
#--------------------------------------------------
#--------------------------------------------------
#--------------------------------------------------

get '/test-local-tunnel' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.say "hello, how are you?"
    r.gather(:num_digits => '1', :action => '/test/handle-gather', :method => 'get') do |g|
      g.say 'if you are already a client press 1'
      g.say 'if you are new press 2'
      g.say 'Press any other key to start over.'
    end
  end.to_s
end

get '/test/handle-gather' do
  #see example params A
  
  redirect '/test-local-tunnel' unless ['1', '2'].include?(params['Digits'])


  if params['Digits'] == '1'
    r.say 'OK. You are a current client.' 
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say "Goodbye"
    end
  elsif params['Digits'] == '2'
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say 'OK. You are new.'
      r.say 'What is your name?'
      r.record(:timeout => '2', :action => '/test/handle-record', :method => 'get' )
    end
  end

  response.to_s
end

get '/test/handle-record' do
  Twilio::TwiML::VoiceResponse.new do |r|
    r.say "Welcome"
    r.play( url: params['RecordingUrl'])
    r.say "Goodbye."
  end.to_s
end

=begin
example params A
{
  "msg"=>"Gather End",
 "Called"=>"+13233783402",
 "Digits"=>"1",
 "ToState"=>"CA",
 "CallerCountry"=>"US",
 "Direction"=>"inbound",
 "CallerState"=>"CA",
 "ToZip"=>"90020",
 "CallSid"=>"CA049c8e2d9b991620280e18d55504b60b",
 "To"=>"+13233783402",
 "CallerZip"=>"95450",
 "ToCountry"=>"US",
 "ApiVersion"=>"2010-04-01",
 "CalledZip"=>"90020",
 "CalledCity"=>"LOS ANGELES",
 "CallStatus"=>"in-progress",
 "From"=>"+17078476844",
 "AccountSid"=>"AC68c705dd59ece4ac8981d44c2ef6c624",
 "CalledCountry"=>"US",
 "CallerCity"=>"CAZADERO",
 "Caller"=>"+17078476844",
 "FromCountry"=>"US",
 "ToCity"=>"LOS ANGELES",
 "FromCity"=>"CAZADERO",
 "CalledState"=>"CA",
 "FromZip"=>"95450",
 "FromState"=>"CA"
}
=end
