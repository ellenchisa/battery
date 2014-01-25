class SmsController < ApplicationController

protect_from_forgery :except => [:index]

    def index

        message_body = params["Body"].downcase
        from_number = params["From"].downcase

        puts message_body,from_number

        user = User.find_by_phone(from_number)

        if user
            if message_body == 'better'
                user.battery.level += 1
            elsif message_body == 'worse'
                user.battery.level -= 1
            elsif message_body == 'same'
                user.battery.level = user.battery.level
            end
            user.battery.save
        end


        render :text => 'okay!'
    end

end
