class User < ApplicationRecord
    validates :name, presence: true, on: :create
    validates :name, uniqueness: true

    has_many :reviews
    has_many :liked_beers
    has_many :disliked_beers
    has_many :beers
end

