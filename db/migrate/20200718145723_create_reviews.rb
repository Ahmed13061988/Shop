class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.string :title
      t.string :content
      t.integer :shop_id
      t.integer :user_id

      t.timestamps
    end
  end
end
