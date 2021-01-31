class AddRoleToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role_id, :bigInt
    add_foreign_key :users, :roles
  end
end
