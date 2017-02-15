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

  it 'returns invoice' do
    db_invoice = create(:invoice)

    get "/api/v1/invoices/#{db_invoice.id}"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id) 
  end
end
