require 'rails_helper'

RSpec.describe Invoice, type: :request do
  it 'returns all invoices' do
    create_list(:invoice, 10)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq 10
    expect(invoices.first.count).to eq 6
    expect(invoices.first).to have_key(:customer_id)
    expect(invoices.first).to have_key(:merchant_id)
  end
end
