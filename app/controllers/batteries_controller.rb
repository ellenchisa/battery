class BatteriesController < ApplicationController
    def index
    end

    def new
        @battery = Battery.new
    end

    def create
        @battery = Battery.create(battery_params)
        @user = User.create(user_params)
        @user.facebookid = session[:fbuser]['id']
        @user.name = session[:fbuser]['name']
        @battery.user = @user
        
        if @battery.save
            redirect_to batteries_url    
        else
            render action: "new"
        end
    end

    def show
        @user = User.find_by_facebookid(session[:fbuser]['id'])
        @battery = @user.battery
    end


    private 
        def battery_params
            params.require(:battery).permit(:level)
        end

        def user_params
            params.require(:user).permit(:phone, :notification_hour)
        end

end

