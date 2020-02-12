class StationsController < ApplicationController
    before_action :authorized, only: [:show, :index]
    def show
        @station = Station.find(params[:id])
    end

    def index
        @stations = Station.all
    end
end
