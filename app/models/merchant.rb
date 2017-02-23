class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items
  has_many :invoices

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group('merchants.id')
    .order('sum(invoice_items.quantity * invoice_items.unit_price) desc')
    .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group('merchants.id')
    .order('sum(invoice_items.quantity) desc')
    .limit(quantity)
  end
end
