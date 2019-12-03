class CreateLikedBeers < ActiveRecord::Migration[6.0]
  def change
    create_table :liked_beers do |t|
      t.integer :user_id
      t.integer :beer_id
      t.index :user_id
      t.index :beer_id

      t.timestamps
    end
  end
end
