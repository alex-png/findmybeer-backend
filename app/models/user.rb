class User < ApplicationRecord

    validates :name, presence: true, on: :create
    validates :name, uniqueness: true
    
end

