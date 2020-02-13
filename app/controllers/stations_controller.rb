class StationsController < ApplicationController
    before_action :authorized, only: [:show, :index]
    
    def index
        @stations = Station.all
        @stations = Station.search(params[:search],params[:id])
    end

    def show
        @station = Station.find(params[:id])
    end
private

def station_params
    params.require(:station).permit(:search)
end

end

