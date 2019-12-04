class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :body
      t.integer :user_id
      t.integer :beer_id
      t.index :user_id
      t.index :beer_id
      t.timestamps
    end
  end
end
