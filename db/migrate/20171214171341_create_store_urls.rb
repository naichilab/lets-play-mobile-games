class CreateStoreUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :store_urls do |t|
      t.belongs_to :game, foreign_key: true
      t.belongs_to :platform, foreign_key: true
      t.string :url
      t.string :memo

      t.timestamps
    end
  end
end
