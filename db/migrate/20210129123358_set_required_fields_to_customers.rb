class SetRequiredFieldsToCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :customers, :name, false
    change_column_null :customers, :surname, false
  end
end
