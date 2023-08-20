class RenameUsersTableField < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :name, :first_name
    rename_column :users, :nickname, :last_name
    rename_column :users, :image, :username
  end
end
