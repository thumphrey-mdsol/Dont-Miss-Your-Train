class TrainsController < ApplicationController
    before_action :authorized, only: [:show, :index]
    def index
        # Train.refresh
        @trains = Train.all
    end
    
end
