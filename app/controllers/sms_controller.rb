class SmsController < ApplicationController

# CSRF protection is disabled for this action because Twilio webhooks cannot include CSRF tokens
# Security is ensured through Twilio's request signature validation below
protect_from_forgery :except => [:index]

    def index

        uri = ENV['TWILIO_WEBHOOK_URL'] || request.url
        signature = request.headers['HTTP_X_TWILIO_SIGNATURE']

        validator = Twilio::Util::RequestValidator.new(Twilio::TOKEN)
        twilio_params = params.reject {|k| k.downcase == k}

        if validator.validate uri, twilio_params, signature
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
