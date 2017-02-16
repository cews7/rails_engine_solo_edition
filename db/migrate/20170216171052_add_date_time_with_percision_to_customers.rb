class AddDateTimeWithPercisionToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :created_at, :datetime, precision: 0
    add_column :customers, :updated_at, :datetime, precision: 0
  end
end
