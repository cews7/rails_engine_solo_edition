require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
  it 'returns all merchants' do
    create_list(:merchant, 10)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body, symbolize_names: true)
    merchant  = merchants.first

    # binding.pry
    expect(Merchant.count).to eq 10
    expect(merchant).to have_key(:name)
  end
end
