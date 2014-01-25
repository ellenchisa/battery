class User < ActiveRecord::Base
    has_many :batteries
    has_one :battery, order: 'created_at DESC'
    validates_presence_of :facebookid, :name, :phone, :notification_hour

    def self.notify
        users = User.all

        twilio_client = Twilio::REST::Client.new Twilio::SID, Twilio::TOKEN

        users.each do |user| 
            puts "sending text message to #{user.phone}"
            twilio_client.account.sms.messages.create(
                :from => '+12486394562',
                :to => user.phone,
                :body => "Are you feeling better or worse today?"
            )
        end
    end


end



# (248) 639-4562