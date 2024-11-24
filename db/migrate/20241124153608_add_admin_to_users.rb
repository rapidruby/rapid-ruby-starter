class AddAdminToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
  end
end
