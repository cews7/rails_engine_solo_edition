require 'rails_helper'

RSpec.describe 'Merchant Relationships', type: :request do
  it 'returns items associated with merchant' do
    merchant = create(:merchant)

    create_list(:item, 10, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_success

    merchant_items = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_items.count).to eq 10
  end

  it 'returns invoices associated with merchant' do
    merchant = create(:merchant)

    create_list(:invoice, 10, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/invoices"
    
    expect(response).to be_success

    merchant_invoices = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_invoices.count).to eq 10
  end
end
