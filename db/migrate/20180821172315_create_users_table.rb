class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :password_hash
      t.date :bday
      t.string :image_url
    end

    create_table :posts do |o|
      o.string :owner
      o.string :author
      o.string :title
      o.string :content
      o.timestamp :created_at
end
    add_index :users, :email, unique: true
  end
end
