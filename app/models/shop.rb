class Shop < ApplicationRecord
    belongs_to :user
    belongs_to :category   
    has_many :reviews
    has_many :users, through: :reviews 

    #accepts_nested_attributes_for :company

    validates :name, presence: true  
    validates :address, uniqueness: true  
    validate :not_a_duplicate 

    scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(stars) desc')}
    scope :most_popular, -> {left_joins(:reviews).group(:id).order('count(reviews.id) desc').limit(3)}  

    def self.alpha
        order(:name) 
    end

    def category_attributes=(attributes)
        self.category = Category.find_or_create_by(attributes) if !attributes['name'].empty?
        self.category 
    end

    def not_a_duplicate
        # if there is already a restaurant with this name and address 
        shop = Shop.find_by(name: name, address: address) 
        if !!shop && shop != self
          errors.add(:name, 'has already been added for that address')
        end
    end 

    def category_name
        category.try(:name)
      end
    
      def name_and_category
        "#{name} - #{category.try(:name)}"
      end
end
