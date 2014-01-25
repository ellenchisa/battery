
module Twilio
  if File.exist?(Rails.root.join("config/twilio.yml")) then
    CONFIG = YAML.load_file(Rails.root.join("config/twilio.yml"))[Rails.env]
    SID = CONFIG['sid']
    TOKEN = CONFIG['token']
  else 
    SID = ENV['sid']
    TOKEN = ENV['token']
  end
end