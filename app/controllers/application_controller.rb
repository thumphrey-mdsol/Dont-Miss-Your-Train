class ApplicationController < ActionController::Base
    def current_user
        if session[:user_id]
            User.find(session[:user_id])
        end
    end

    def logged_in?
        current_user
    end
    
    def authorized
        redirect_to welcome_path unless logged_in? 
        # flash[:error] = "Please sign in to browse site." && 
    end
end
