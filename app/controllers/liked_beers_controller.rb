class LikedBeersController < ApplicationController

    def initial_create
        user = User.all.find(params[:user_id])
        
        data = params[:data]

        data.each do |o|
            register_liked_beer(o)
        end

        style1 = Style.find(user.beers[-1].style.id)
        style1_beers = style1.beers
        recc_beers = style1_beers


        render json: recc_beers, include: [:style, :brewery]



    end




    def create
        register_liked_beer()
    end

    private

    def register_liked_beer(obj)
    liked_beer = LikedBeer.new(user_id: params[:user_id], beer_id: obj )
    liked_beer.save
        
    end

end ##end of class
