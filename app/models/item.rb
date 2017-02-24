class Item < ApplicationRecord
  validates :name, :description, :unit_price, :merchant_id, presence: true
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    select('items.*')
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order('sum(invoice_items.quantity * invoice_items.unit_price) desc')
    .take(quantity)
  end

  def self.most_items_sold(quantity)
    select('items.*')
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order('sum(invoice_items.quantity) desc')
    .take(quantity)
  end
end
