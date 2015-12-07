class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_token, :string, default: "", unique: true
    add_column :users, :password, :string
    add_index :users, :auth_token
  end
end
