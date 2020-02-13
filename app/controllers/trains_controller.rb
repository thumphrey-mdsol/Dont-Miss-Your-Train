class TrainsController < ApplicationController
    before_action :authorized, only: [:show, :index]
    def index
        @trains = Train.all
    end
    
end
