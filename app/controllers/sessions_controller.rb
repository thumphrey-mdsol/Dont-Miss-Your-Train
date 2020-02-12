class SessionsController < ApplicationController
    def new
        @errors = flash[:errors]
    end
    
    def create
        user = User.find_by(user_name: params[:username])
    
        if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to home_path
        else
        flash[:errors] = ["Username or Password does not match records on file."]
        redirect_to login_path
        end
    end
    
    
    def welcome
        @error = flash[:error]
        render 'welcome'
    end
    
    def destroy
        session[:user_id] = nil
        redirect_to '/welcome'
    end
      
end
