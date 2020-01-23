class LikedBeer < ApplicationRecord
    validates_uniqueness_of :user_id, scope: :beer_id

    belongs_to :user
end
