class AddUserToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :user_id, :integer, index: true
  end
end
