require 'rails_helper'

RSpec.describe 'Items Business Intelligence' do
  it 'returns top x (1 for this test) items ranked by total revenue' do
    item     = create(:item)
    top_item = create(:item, name: 'Pencil')

    item.invoice_items << create_list(:invoice_item, 2, unit_price: 1, quantity: 1)
    top_item.invoice_items << create_list(:invoice_item, 2, unit_price: 2, quantity: 2)

    item.invoices.first.transactions << create(:transaction, result: 'success')
    top_item.invoices.first.transactions << create(:transaction, result: 'success')

    get "/api/v1/items/most_revenue?quantity=1"

    expect(response).to be_success

    most_rev_item = JSON.parse(response.body)

    expect(most_rev_item.first).to have_value('Pencil')
  end

  # /api/v1/items/most_items?quantity=x

  it 'returns top x (1 for this test) items ranked by sold count' do
    item_least_sold = create(:item)
    item_most_sold  = create(:item, name: 'Pink Hat')

    item_least_sold.invoice_items << create_list(:invoice_item, 2, unit_price: 1, quantity: 1)
    item_most_sold.invoice_items << create_list(:invoice_item, 4, unit_price: 1, quantity: 1)

    item_least_sold.invoices.each do |invoice|
      invoice.transactions << create(:transaction, result: 'success')
    end

    item_most_sold.invoices.each do |invoice|
      invoice.transactions << create(:transaction, result: 'success')
    end

    get "/api/v1/items/most_items?quantity=1"

    top_sold_item = JSON.parse(response.body)

    expect(top_sold_item.first).to have_value('Pink Hat')
  end
end
