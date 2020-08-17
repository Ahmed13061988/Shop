class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_shops, through: :reviews, source: :shop 

    has_many :shops

    has_secure_password 

    validates :username, presence: true, uniqueness: true 
    validates :email, presence: true 

  
end
