require 'rails_helper'

RSpec.describe 'Invoice Relationships', type: :request do
  it 'returns a collection of associated transactions' do
    invoice = create(:invoice)
    create_list(:transaction, 10, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/transactions"
    expect(response).to be_success

    invoice_with_transactions = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_with_transactions.count).to eq 10
  end

  it 'returns a collection of associated invoice_items' do
    invoice = create(:invoice)
    create_list(:invoice_item, 10, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    expect(response).to be_success

    invoice_items = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_items.count).to eq 10
  end

  it 'returns a collection of associated items' do
    invoice = create(:invoice)
    item    = create(:item)
    create_list(:invoice_item, 10, invoice_id: invoice.id, item_id: item.id)

    get "/api/v1/invoices/#{invoice.id}/items"

    expect(response).to be_success

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq 1
  end
end
