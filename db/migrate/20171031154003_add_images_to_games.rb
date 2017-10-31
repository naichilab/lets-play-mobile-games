class AddImagesToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :image1, :string
    add_column :games, :image2, :string
    add_column :games, :image3, :string
    add_column :games, :image4, :string
    add_column :games, :image5, :string
  end
end
