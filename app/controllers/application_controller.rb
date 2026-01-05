class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_security_headers

  def set_security_headers
    response.headers['X-Frame-Options'] = 'SAMEORIGIN'
    response.headers['X-Content-Type-Options'] = 'nosniff'
    response.headers['X-XSS-Protection'] = '1; mode=block'
  end

    def is_logged_in
        redirect_to root_url if session[:fbuser] == nil
    end

    def has_battery
        return redirect_to root_url if session[:fbuser].nil?
        redirect_to battery_url if User.find_by_facebookid(session[:fbuser]['id']) != nil
    end

    def no_battery
        return redirect_to root_url if session[:fbuser].nil?
        redirect_to battery_new if User.find_by_facebookid(session[:fbuser]['id']) == nil
    end

end