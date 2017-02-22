require 'rails_helper'

RSpec.describe 'Customer Relationships' do
  it 'returns collection of associated invoices' do
    customer = create(:customer)
    create_list(:invoice, 10, customer_id: customer.id)
    create(:invoice)

    get "/api/v1/customers/#{customer.id}/invoices"

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq 10
    expect(invoices.first).to have_key(:customer_id)
    expect(invoices.first).to have_key(:merchant_id)
    expect(invoices.first).to have_key(:status)
  end

  it 'returns collection of associated transactions' do
    customer = create(:customer)
    invoice  = create(:invoice, customer_id: customer.id)
    invoice.transactions << create_list(:transaction, 10)

    get "/api/v1/customers/#{customer.id}/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body, symbolize_names: true)

    expect(transactions.count).to eq 10
    expect(transactions.first).to have_key(:invoice_id)
    expect(transactions.first).to have_key(:credit_card_number)
    expect(transactions.first).to have_key(:result)
  end
end
