require 'rails_helper'

RSpec.describe Item, type: :request do
  it 'returns all items' do
    create_list(:item, 10)

    get '/api/v1/items'

    expect(response).to be_success

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq 10
    expect(items.first.count).to eq 7

    expect(items.first).to have_key(:name)
    expect(items.first).to have_key(:description)
    expect(items.first).to have_key(:unit_price)
    expect(items.first).to have_key(:merchant_id)
  end

  it 'returns all items -- name lookup' do
    merchant       = create(:merchant)
    db_item_clone1 = Item.create(id: 1, name: "hammer", description: "example", unit_price: 1, merchant_id: merchant.id)
    db_item_clone2 = Item.create(id: 2, name: "hammer", description: "example", unit_price: 1, merchant_id: merchant.id)
    db_item_uniq   = Item.create(id: 3, name: "macbook", description: "example", unit_price: 1, merchant_id: merchant.id)

    get "/api/v1/items/find_all?name=macbook"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 1
    expect(item.first.count).to eq 7
    expect(item.first).to have_key(:name)
    expect(item.first).to have_key(:description)
    expect(item.first).to have_key(:unit_price)
    expect(item.first).to have_key(:merchant_id)
    expect(item.first).to have_value("macbook")
  end

  it 'returns all items -- merchant_id lookup' do
    merchant       = create(:merchant)
    merchant2       = create(:merchant, id: 3)
    db_item_clone1 = Item.create(id: 1, name: "hammer", description: "example", unit_price: 1, merchant_id: merchant.id)
    db_item_clone2 = Item.create(id: 2, name: "hammer", description: "example", unit_price: 1, merchant_id: merchant.id)
    db_item_uniq   = Item.create(id: 3, name: "macbook", description: "example", unit_price: 1, merchant_id: merchant2.id)

    get "/api/v1/items/find_all?merchant_id=3"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 1
    expect(item.first.count).to eq 7
    expect(item.first).to have_key(:name)
    expect(item.first).to have_key(:description)
    expect(item.first).to have_key(:unit_price)
    expect(item.first).to have_key(:merchant_id)
    expect(item.first).to have_value("macbook")
  end

  it 'returns all items -- unit_price lookup' do
    merchant       = create(:merchant)
    db_item_clone1 = Item.create(id: 1, name: "hammer", description: "example", unit_price: 1, merchant_id: merchant.id)
    db_item_clone2 = Item.create(id: 2, name: "hammer", description: "example", unit_price: 1, merchant_id: merchant.id)
    db_item_uniq   = Item.create(id: 3, name: "macbook", description: "example", unit_price: 2, merchant_id: merchant.id)

    get "/api/v1/items/find_all?unit_price=2"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 1
    expect(item.first.count).to eq 7
    expect(item.first).to have_key(:name)
    expect(item.first).to have_key(:description)
    expect(item.first).to have_key(:unit_price)
    expect(item.first).to have_key(:merchant_id)
    expect(item.first).to have_value("macbook")
  end

  it 'returns item -- id lookup' do
    db_item = create(:item)

    get "/api/v1/items/#{db_item.id}"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 7
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:unit_price)
    expect(item).to have_key(:merchant_id)
  end

  it 'returns item -- name lookup' do
    db_item = create(:item)

    get "/api/v1/items/find?name=#{db_item.name}"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 7
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:unit_price)
    expect(item).to have_key(:merchant_id)
  end

  it 'returns item -- merchant_id lookup' do
    db_item = create(:item)

    get "/api/v1/items/find?merchant_id=#{db_item.merchant_id}"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 7
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:unit_price)
    expect(item).to have_key(:merchant_id)
  end

  it 'returns item -- unit_price lookup' do
    db_item = create(:item)

    get "/api/v1/items/find?unit_price=#{db_item.unit_price}"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 7
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:unit_price)
    expect(item).to have_key(:merchant_id)
  end

  it 'returns item -- created_at lookup' do
    db_item = create(:item)

    get "/api/v1/items/find?created_at=#{db_item.created_at}"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 7
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:unit_price)
    expect(item).to have_key(:merchant_id)
  end

  it 'returns item -- updated_at lookup' do
    db_item = create(:item)

    get "/api/v1/items/find?updated_at=#{db_item.updated_at}"

    expect(response).to be_success

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item.count).to eq 7
    expect(item).to have_key(:name)
    expect(item).to have_key(:description)
    expect(item).to have_key(:unit_price)
    expect(item).to have_key(:merchant_id)
  end

  it 'returns random item' do
    create_list(:item, 10)

    get '/api/v1/items/random.json'

    item_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(item_attrs.count).to eq 7
    expect(item_attrs).to have_key(:name)
    expect(item_attrs).to have_key(:description)
    expect(item_attrs).to have_key(:unit_price)
    expect(item_attrs).to have_key(:merchant_id)
  end
end
