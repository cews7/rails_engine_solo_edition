class Invoice < ApplicationRecord
  validates :merchant_id, :customer_id, :status, presence: true
end
