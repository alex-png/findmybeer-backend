class LikedBeersController < ApplicationController

    def initial_create
        user = User.all.find(params[:user_id])
        data = params[:data]

        recc_beers = []
  
        data.each do |pref| 
            if pref.to_i == 1
                marg = get_beers(" lime")
                marg.each{|b| recc_beers << b}
            elsif pref.to_i == 2
                coffee = get_beers("coffee")
                coffee.each{|b| recc_beers << b}
            elsif pref.to_i == 3
                olfash = get_beers("smoke")
                olfash.each{|b| recc_beers << b}
            elsif pref.to_i == 4 
                choc = get_beers("chocholate")
                choc.each{|b| recc_beers << b}
            elsif pref.to_i == 5
                coc = get_beers("coconut")
                coc.each{|b| recc_beers << b}
            elsif pref.to_i == 6
                recc_beers << (butter = Beer.find(297))
                recc_beers << (witch = Beer.find(8))
            end
        end
        recc_beers = recc_beers.shuffle
        
        render json: recc_beers, include: [:style, :brewery]
    end

    def create
        register_liked_beer()
    end

    private
    def get_beers(noun)
        arr = Beer.all.select{ |b| b.description.downcase.include?("#{noun}")  }
        return arr
    end

    def register_liked_beer(obj)
    liked_beer = LikedBeer.new(user_id: params[:user_id], beer_id: obj )
    liked_beer.save
    end

end ##end of class
