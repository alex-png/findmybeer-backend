class LikedBeersController < ApplicationController

    def initial_create
        user = User.find(params[:user_id])
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
        send_recc_beers(recc_beers)
        
    end

    def create
        byebug


        register_liked_beer()
    end


    def create_recc_beers
        user = User.find(params[:user_id])
        if user.liked_beers.size >= 3
            recc_beers = []
            first = user.liked_beers[-1].style.beers
            second = user.liked_beers[-2].style.beers
            third = user.liked_beers[-3].style.beers
            first.each{|b| recc_beers << b}
            second.each{|b| recc_beers << b}
            third.each{|b| recc_beers << b}
            send_recc_beers(recc_beers)
        else
            recc_beers = []
            send_recc_beers(recc_beers)
        end
        
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
     
    ##Will be called only after initial 
    def send_recc_beers(recc_beers)
        render json: recc_beers, include: [:style, :brewery]

    end


end ##end of class
