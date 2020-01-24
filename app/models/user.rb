class User < ApplicationRecord
    validates :name, presence: true, on: :create
    validates :name, uniqueness: true

    has_many :reviews
    has_many :liked_beers
    
    has_many :beers, through: :liked_beers
    has_many :disliked_beers

end

##checking to see if this committed 
