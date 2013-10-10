class AddPerishableTokenToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :perishable_token, :string
    add_index :admin_users, :perishable_token
  end
end