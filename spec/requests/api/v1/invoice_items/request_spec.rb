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

  it 'returns invoice_item -- id lookup' do
    db_invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{db_invoice_item.id}"

    invoice_item_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item_attrs.count).to eq 7

    expect(invoice_item_attrs).to have_key(:item_id)
    expect(invoice_item_attrs).to have_key(:invoice_id)
    expect(invoice_item_attrs).to have_key(:quantity)
    expect(invoice_item_attrs).to have_key(:unit_price)
  end

  it 'returns invoice_item -- item_id lookup' do
    db_invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?item_id=#{db_invoice_item.item_id}"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item.count).to eq 7
    expect(invoice_item).to have_key(:item_id)
    expect(invoice_item).to have_key(:invoice_id)
    expect(invoice_item).to have_key(:quantity)
    expect(invoice_item).to have_key(:unit_price)
  end

  it 'returns invoice_item -- invoice_id lookup' do
    db_invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?invoice_id=#{db_invoice_item.invoice_id}"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item.count).to eq 7
    expect(invoice_item).to have_key(:item_id)
    expect(invoice_item).to have_key(:invoice_id)
    expect(invoice_item).to have_key(:quantity)
    expect(invoice_item).to have_key(:unit_price)
  end

  it 'returns invoice_item -- quantity lookup' do
    db_invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{db_invoice_item.quantity}"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item.count).to eq 7
    expect(invoice_item).to have_key(:item_id)
    expect(invoice_item).to have_key(:invoice_id)
    expect(invoice_item).to have_key(:quantity)
    expect(invoice_item).to have_key(:unit_price)
  end

  it 'returns invoice_item -- unit_price lookup' do
    db_invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?unit_price=#{db_invoice_item.unit_price}"

    expect(response).to be_success

    invoice_item = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item.count).to eq 7
    expect(invoice_item).to have_key(:item_id)
    expect(invoice_item).to have_key(:invoice_id)
    expect(invoice_item).to have_key(:quantity)
    expect(invoice_item).to have_key(:unit_price)
  end

  it 'returns random invoice_item' do
    create_list(:invoice_item, 10)

    get '/api/v1/invoice_items/random.json'

    expect(response).to be_success

    invoice_item_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_item_attrs.count).to eq 7
    expect(invoice_item_attrs).to have_key(:item_id)
    expect(invoice_item_attrs).to have_key(:invoice_id)
    expect(invoice_item_attrs).to have_key(:quantity)
    expect(invoice_item_attrs).to have_key(:unit_price)
  end
end
