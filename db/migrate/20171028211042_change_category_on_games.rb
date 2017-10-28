class ChangeCategoryOnGames < ActiveRecord::Migration[5.1]
  def up
    add_column :games, :category_id, :integer
    remove_column :games, :category
  end

  def down
    remove_column :games, :category_id
    add_column :games, :category, :integer
  end
end
