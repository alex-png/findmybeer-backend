class Beer < ApplicationRecord
    belongs_to :style
    belongs_to :brewery

    has_many :liked_beers
    has_many :users, through: :liked_beer
end
