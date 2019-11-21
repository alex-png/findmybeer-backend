class AddStyleIdToBeers < ActiveRecord::Migration[6.0]
  def change
    add_column :beers, :style_id, :integer
    add_index :beers, :style_id

  end
end
