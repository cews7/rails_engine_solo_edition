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

  it 'returns merchant' do
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
end
