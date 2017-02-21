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
end
