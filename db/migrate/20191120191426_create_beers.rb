class CreateBeers < ActiveRecord::Migration[6.0]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :description
      t.integer :abv

      t.timestamps
    end
  end
end
