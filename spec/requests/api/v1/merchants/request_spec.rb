require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  it 'returns all merchants' do
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant  = merchants.first

    expect(Merchant.count).to eq 10
    expect(merchant).to have_key(:name)
  end

  it 'returns all merchants -- name lookup' do
    db_merchant_clone1 = Merchant.create(id: 1, name: "John")
    db_merchant_clone1 = Merchant.create(id: 2, name: "John")
    db_merchant_uniq   = Merchant.create(id: 3, name: "Tim")

    get "/api/v1/merchants/find_all?name=#{db_merchant_uniq.name}"

    expect(response).to be_success

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant.count).to eq 1
    expect(merchant.first).to have_key(:name)
    expect(merchant.first).to have_value("Tim")
  end

  it 'returns merchant -- id lookup' do
    db_merchant = create(:merchant)

    get "/api/v1/merchants/#{db_merchant.id}"

    expect(response).to be_success

    merchant_attrs = JSON.parse(response.body)

    expect(merchant_attrs.count).to eq 4
    expect(Merchant.count).to eq 1
  end

  it 'returns merchant -- name lookup' do
    db_merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{db_merchant.name}"

    expect(response).to be_success

    merchant_attrs = JSON.parse(response.body)

    expect(merchant_attrs.count).to eq 4
    expect(Merchant.count).to eq 1
  end

  it 'returns merchant -- created_at lookup' do
    db_merchant = create(:merchant)

    get "/api/v1/merchants/find?created_at=#{db_merchant.created_at}"

    expect(response).to be_success

    merchant_attrs = JSON.parse(response.body)

    expect(merchant_attrs.count).to eq 4
    expect(Merchant.count).to eq 1
  end

  it 'returns merchant -- updated_at lookup' do
    db_merchant = create(:merchant)

    get "/api/v1/merchants/find?updated_at=#{db_merchant.created_at}"

    expect(response).to be_success

    merchant_attrs = JSON.parse(response.body)

    expect(merchant_attrs.count).to eq 4
    expect(Merchant.count).to eq 1
  end

  it 'returns random merchant' do
    create_list(:merchant, 10)

    get '/api/v1/merchants/random.json'

    merchant_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_attrs.count).to eq 4
    expect(merchant_attrs).to have_key(:name)
    expect(merchant_attrs).to have_key(:created_at)
    expect(merchant_attrs).to have_key(:updated_at)
  end
end
