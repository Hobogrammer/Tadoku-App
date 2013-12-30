class SessionsController < ApplicationController

    def create
        auth = request.env["omniauth.auth"]
        if auth["extra"]["raw_info"]["time_zone"].nil?
            flash[:error] = " Sorry, you could not be signed in. Make sure your twitter account's timezone is set and try again."
            redirect_to root_url
        else
            @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
            session[:user_id] = @user.id
            self.current_user = @user
            redirect_to root_url, :flash => { :success => "Signed in!" }
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Signed out"
    end
end
