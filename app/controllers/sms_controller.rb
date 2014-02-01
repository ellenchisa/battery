class SmsController < ApplicationController

protect_from_forgery :except => [:index]

    def index

        message_body = params["Body"].downcase
        from_number = params["From"].downcase

        puts message_body,from_number

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

        render :text => 'okay!'
    end

end
