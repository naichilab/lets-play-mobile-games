class AddIconToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :icon, :string
  end
end
