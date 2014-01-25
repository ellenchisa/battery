class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def is_logged_in
        redirect_to root_url if session[:fbuser] == nil
    end

    def has_battery
        redirect_to battery_url if User.find_by_facebookid(session[:fbuser]['id']) != nil
    end

    def no_battery
        redirect_to battery_new if User.find_by_facebookid(session[:fbuser]['id']) == nil
    end

end