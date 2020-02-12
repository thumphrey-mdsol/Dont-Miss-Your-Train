class FavoritesController < ApplicationController
    def new
        @favorite = Favorite.new
        @errors = flash[:errors]
        @stations = Station.all
    end

    def create
        @favorite = Favorite.new(user_id: session[:user_id], station_id: favorites_params[:station_id])
        if @favorite.valid?
            @favorite.save
            redirect_to home_path
        else
            flash[:error] = @favorite.errors.full_messages
            redirect_to new_ul_path
        end
    end

    def destroy
        @favorite = Favorite.find(params[:id])
        @favorite.destroy
        redirect_to home_path
    end
    

    private
    def favorites_params
        params.require(:favorite).permit(:station_id)
    end
    
end
