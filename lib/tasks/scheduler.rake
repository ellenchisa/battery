desc "This task is called by the Heroku scheduler add-on"
task :send_sms => :environment do
    User.notify
end