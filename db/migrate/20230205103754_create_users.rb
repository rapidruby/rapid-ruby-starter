class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name,      null: false
      t.string :last_name,       null: false
      t.string :email,           null: false
      t.string :password_digest, null: false

      t.boolean :verified, null: false, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
