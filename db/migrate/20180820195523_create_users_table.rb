class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |u|
      u.string :name
      u.string :last_name
      u.string :email
      u.string :password_hash
      u.date :bday
    end

    add_index :users, :email, unique: true

  end
end
