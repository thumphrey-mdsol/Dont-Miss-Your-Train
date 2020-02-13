class StationsController < ApplicationController
    before_action :authorized, only: [:show, :index]
    
    def index
        @stations = Station.all
        @stations = Station.search(params[:search],params[:id])
        @fav = Favorite.new
    end

    def show
        @station = Station.find(params[:id])
        @trains = @station.trains
    end

    # def create
    #     @favorite = Favorite.create(favorite_params)
    #     redirect_to stations_path
    # end 
private

    def station_params
        params.require(:station).permit(:search)
    end

    # def favorites_params
    #     params.require(:favorite).permit(:station_id, :label)
    # end


end

