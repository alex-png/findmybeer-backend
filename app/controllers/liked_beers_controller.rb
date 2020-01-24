class LikedBeersController < ApplicationController

    def initial_create
        user = User.find(params[:user_id])
        data = params[:data]

        recc_beers = []
  
        data.each do |pref| 
            if pref.to_i == 1
                marg = get_beers(" lime")
                marg = marg.shuffle
                marg[0..1].each{|b| recc_beers << b}
            elsif pref.to_i == 2
                coffee = get_beers("coffee")
                coffee = coffee.shuffle
                coffee[0..1].each{|b| recc_beers << b}
            elsif pref.to_i == 3
                olfash = get_beers("smoke")
                olfash = olfash.shuffle
                olfash[0..1].each{|b| recc_beers << b}

                whisk = get_beers("whiskey")
                whisk = whisk.shuffle

                whisk[0..1].each{|b| recc_beers << b}

            elsif pref.to_i == 4 
                choc = get_beers("chocholate")
                choc = choc.shuffle

                choc[0..1].each{|b| recc_beers << b}
            elsif pref.to_i == 5
                coc = get_beers("coconut")
                coc = coc.shuffle

                pineapp = get_beers("pineapple")
                pineapp = pineapp.shuffle


                coc[0..1].each{|b| recc_beers << b}
                pineapp[0..1].each{|b| recc_beers << b}
            elsif pref.to_i == 6
                recc_beers << (butter = Beer.find(297))
                recc_beers << (witch = Beer.find(8))
            elsif pref.to_i == 7
                wine = get_beers("wine")
                wine = wine.shuffle
                wine[0..1].each{|b| recc_beers << b}
            elsif pref.to_i == 8
                berry = get_beers("erries")
                berry = berry.shuffle

                berry[0..1].each{|b| recc_beers << b}                
            elsif pref.to_i == 9
                orange = get_beers("orange")
                orange = orange.shuffle

                orange[0..1].each{|b| recc_beers << b}            
            end ## end of if
            
        end ## end of each


        rec_beers = recc_beers.shuffle
        send_recc_beers(recc_beers)
        
    end  ##end of meth

    def create
        user = User.find(params[:user_id])
        
        register_liked_beer
        
        create_recc_beers


    end ##




    def create_recc_beers
    
        user = User.find(params[:user_id])

        recc_beers = []
        if user.liked_beer.size == 0 
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
            last_similar = last_similar.select{|b| user.beers.include?(b) == false && user.disliked_beers.include?( user.disliked_beers.find_by(beer_id: b.id)   ) == false }[1..2]

            second_similar = Beer.all.sort_by{ |b| -(b.name.similar(second.name)) }
            second_similar = second_similar.select{|b| user.beers.include?(b) == false && user.disliked_beers.include?( user.disliked_beers.find_by(beer_id: b.id)    ) == false }[1..2]


            third_similar = Beer.all.sort_by{ |b| -(b.name.similar(third.name)) }
            third_similar = third_similar.select{|b| user.beers.include?(b) == false && user.disliked_beers.include?( user.disliked_beers.find_by(beer_id: b.id)    ) == false }[1..2]
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
            
            last_similar = last_similar.select{|b| user.beers.include?(b) == false && user.disliked_beers.include?(user.disliked_beers.find_by(beer_id: b.id)) == false }[1..2]
            "sorted beer / user not inculded"
            last_similar.each{|b| recc_beers << b}

        
        end
        ##then..
        send_recc_beers(recc_beers)
    end ##


    def new_liking
        user = User.find(params[:user_id])
        register_liked_beer
        user.list_of_available_beers = user.list_of_available_beers - user.liked_beers
        ##then user.list of available beers calls on create reccomnation, create recs uses list of beers instead of comparing between liked and disliked.

    end


























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
