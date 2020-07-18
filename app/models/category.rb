class Category < ApplicationRecord
    has_many :shops 

    validates :name, presence: true, uniqueness: true  

    scope :alpha, -> {order(:name)} 

end
