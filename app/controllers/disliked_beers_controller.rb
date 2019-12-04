class DislikedBeersController < ApplicationController
    def create
        disliked_beer = DislikedBeer.new(user_id: params[:user_id], beer_id: params[:beer_id] )
        disliked_beer.save

        render json: disliked_beer

    end
end
