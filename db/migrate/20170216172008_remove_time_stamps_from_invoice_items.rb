class RemoveTimeStampsFromInvoiceItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :invoice_items, :created_at
    remove_column :invoice_items, :updated_at
  end
end
