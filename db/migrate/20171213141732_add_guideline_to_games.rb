class AddGuidelineToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :guideline, :text
  end
end
