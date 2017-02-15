require 'rails_helper'

RSpec.describe Item, type: :request do
  it 'gives full list of items' do
    items = create_list(:item, 10)

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
end
