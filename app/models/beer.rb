class Beer < ApplicationRecord
    belongs_to :style
    belongs_to :brewery
end
