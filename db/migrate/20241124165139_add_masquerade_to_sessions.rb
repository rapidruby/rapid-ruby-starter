class AddMasqueradeToSessions < ActiveRecord::Migration[8.0]
  def change
    add_reference :sessions, :admin_user, null: true, foreign_key: { to_table: :users }
    add_column :sessions, :masquerade_at, :datetime
  end
end
