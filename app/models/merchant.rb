class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

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

  def self.revenue(date = nil)
    return revenue_by_date(date) if date
    joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def self.revenue_by_date(date)
    where(created_at: date)
    .joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end
