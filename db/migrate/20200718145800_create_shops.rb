class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :name 
      t.string :price_range
      t.string :address 
      t.integer :user_id
      t.integer :category_id  


      t.timestamps
    end
  end
end
