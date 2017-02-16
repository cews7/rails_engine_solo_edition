class RemoveTimeStampsFromCustomers < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :created_at
    remove_column :customers, :updated_at
  end
end
