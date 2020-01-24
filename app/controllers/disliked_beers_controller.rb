class DislikedBeersController < ApplicationController
    def create
        disliked_beer = DislikedBeer.new(user_id: params[:user_id], beer_id: params[:beer_id] )
        disliked_beer.save
        render json: disliked_beer

    end

    def new_create_psudeo_code

    def new_liking

        user = User.find(params[:user_id])
        user.list_of_available_beers = user.list_of_available_beers - user.disliked_beers
        ##then user.list of available beers calls on create reccomnation, create recs uses list of beers instead of comparing between liked and disliked.

    end
    end
end
