class AddImgUrlToBeers < ActiveRecord::Migration[6.0]
  def change
    add_column :beers, :img_url, :string
  end
end
