class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :surname
      t.bigint :creator_id
      t.bigint :modifier_id

      t.timestamps
    end

    add_foreign_key :customers, :users, column: :creator_id, on_delete: :nullify
    add_foreign_key :customers, :users, column: :modifier_id, on_delete: :nullify
  end
end
