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
                whisk = get_beers("whiskey")
                whisk.each{|b| recc_beers << b}
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
        send_recc_beers(recc_beers)
        
    end

    def create
        user = User.find(params[:user_id])
        
        register_liked_beer
        
        create_recc_beers


    end ##




    def create_recc_beers
    
        user = User.find(params[:user_id])

        recc_beers = []
        if user.beers.size == 0 
            recc_beers << "nothing..."
        elsif user.beers.size % 3 == 0 && user.beers.size != 0
             ##setting variables for the last three beers. easier to read/use
            last = user.beers[-1]
            second = user.beers[-2]
            third = user.beers[-3]
            ##getting first 10 beers that are most similar in description to last three beers
            num = rand(10)
            sec_num = num + 3

            last_similar = Beer.all.sort_by{ |b| -(b.name.similar(last.name)) }
            last_similar = last_similar.select{|b| !user.beers.include?(b) }[num..sec_num]

            second_similar = Beer.all.sort_by{ |b| -(b.name.similar(second.name)) }
            second_similar = second_similar.select{|b| !user.beers.include?(b) }[num..sec_num]


            third_similar = Beer.all.sort_by{ |b| -(b.name.similar(third.name)) }
            third_similar = third_similar.select{|b| !user.beers.include?(b) }[num..sec_num]
            ##pushing each object of beer into recc beers
            
            last_similar.each{|b| recc_beers << b}

            second_similar.each{|b| recc_beers << b}

            third_similar.each{|b| recc_beers << b}
        else
            num = rand(10)
            sec_num = num + 3

            last = user.beers[-1]
            last_similar = Beer.all.sort_by{ |b| -(b.name.similar(last.name)) }
            "JUST BEER"
            
            last_similar = last_similar.select{|b| !user.beers.include?(b) }[num..sec_num]
            "sorted beer / user not inculded"
            last_similar.each{|b| recc_beers << b}

        
        end
        ##then..
        send_recc_beers(recc_beers)
    end ##

    private
    def get_beers(noun)
        arr = Beer.all.select{ |b| b.description.downcase.include?("#{noun}")  }
        return arr
    end

    def register_liked_beer
    liked_beer = LikedBeer.new(user_id: params[:user_id], beer_id: params[:beer_id] )
    liked_beer.save
    end
     
    ##Will be called only after initial 
    def send_recc_beers(recc_beers)
        recc_beers = recc_beers.uniq
        recc_beers = recc_beers.shuffle
        render json: recc_beers, include: [:style, :brewery, :reviews]

    end


end ##end of class
