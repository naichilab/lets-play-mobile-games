class RemovePermissionFromUsers < ActiveRecord::Migration[5.1]
  def up
    remove_column :games, :permission
  end

  def down
    add_column :games, :permission, :boolean, null: false, default: '0'
  end
end
