require 'rails_helper'

RSpec.describe InvoiceItem, type: :request do
  it 'returns all invoice_items' do
    create_list(:invoice_item, 10)

    get '/api/v1/invoice_items'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_items.count).to eq 10
    expect(invoice_items.first.count).to eq 7

    expect(invoice_items.first).to have_key(:item_id)
    expect(invoice_items.first).to have_key(:invoice_id)
    expect(invoice_items.first).to have_key(:quantity)
    expect(invoice_items.first).to have_key(:unit_price)
  end
end
