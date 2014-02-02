class SmsController < ApplicationController

protect_from_forgery :except => [:index]

    def index

        if params["AccountSid"] == Twilio::SID

            message_body = params["Body"].downcase
            from_number = params["From"].downcase

            user = User.find_by_phone(from_number)

            if user
                battery = Battery.new
                if message_body == 'better'
                    battery.level = user.battery.level + 1
                elsif message_body == 'worse'
                    battery.level = user.battery.level - 1
                elsif message_body == 'same'
                    battery.level = user.battery.level
                end
                user.batteries << battery
                user.save!
            end
        end

        response = Twilio::TwiML::Response.new
        render :text => response.text
        
    end

end
