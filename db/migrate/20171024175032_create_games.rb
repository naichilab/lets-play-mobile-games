class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :title, null:false, default: ''
      t.boolean :permission, null:false, default: '0'
      t.string :specific_conditions
      t.string :android_url
      t.string :ios_url

      t.timestamps
    end
  end
end
