class HomeController < ApplicationController

    def index 
        
    end 

    def oauth
        oauth = Koala::Facebook::OAuth.new(oauth_url)

        access_token = oauth.get_access_token(params[:code])

        graph= Koala::Facebook::API.new(access_token)
        fb_user= graph.get_object('me')

        session[:fbuser] = fb_user

        redirect_to root_url
    end

    def logout
        session[:fbuser] = nil
        redirect_to root_url
    end

end
