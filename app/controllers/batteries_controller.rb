class BatteriesController < ApplicationController

    before_filter :is_logged_in
    before_filter :has_battery, :except => ['show']
    before_filter :no_battery, :only => ['show']

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
            redirect_to battery_url    
        else
            render action: "new"
        end
    end

    def show
        @user = User.find_by_facebookid(session[:fbuser]['id'])
        @battery = @user.battery

        puts @user.id
        puts @battery.id
    end


    private 
        def battery_params
            params.require(:battery).permit(:level)
        end

        def user_params
            params.require(:user).permit(:phone, :notification_hour)
        end

end

