require 'rails_helper'

RSpec.describe 'Transaction Relationships' do
  it 'returns associated invoice' do
    transaction = create(:transaction)
    invoice     = create(:invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:status)
  end
end
