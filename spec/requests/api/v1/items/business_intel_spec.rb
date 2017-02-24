require 'rails_helper'

RSpec.describe 'Items Business Intelligence' do
  it 'returns top x (1 as default) items ranked by total revenue' do
    item     = create(:item)
    top_item = create(:item, name: 'Pencil')

    item.invoice_items << create_list(:invoice_item, 2, unit_price: 1, quantity: 1)

    top_item.invoice_items << create_list(:invoice_item, 2, unit_price: 2, quantity: 2)

    item.invoices.first.transactions << create(:transaction, result: 'success')
    top_item.invoices.first.transactions << create(:transaction, result: 'success')

    get "/api/v1/items/most_revenue?quantity=1"

    expect(response).to be_success

    most_rev_item = JSON.parse(response.body, symbolize_names: true)

    expect(most_rev_item.first).to have_value('Pencil')
  end
end
