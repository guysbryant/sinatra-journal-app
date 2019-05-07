class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.strinng :email
      t.string :password_digest #allows bcrypt to encrypt password
      t.timestamps null: false
    end
  end
end
