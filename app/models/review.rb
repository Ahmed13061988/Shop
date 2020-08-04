class Review < ApplicationRecord
    belongs_to :user 
    belongs_to :shop

    validates :title, presence: true  
    validates :title, length: {maximum: 25}
    validates :content, length: {maximum: 250} 
    validates :stars, numericality: {only_integer: true, in: 1...5 } # among 1 and 5 
    
    validates :shop, uniqueness: { scope: :user, message: "has already been reviewed by you"  } # you can review the shop just one time 
end
