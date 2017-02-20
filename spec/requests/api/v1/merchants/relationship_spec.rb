require 'rails_helper'

RSpec.describe 'Merchant Relationships', type: :request do
  describe '/api/v1/merchant/:id/items' do
    it 'returns items associated with merchant' do
      merchant = create(:merchant)

      create_list(:item, 10, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/items"

      merchant_items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_success
      expect(merchant_items.count).to eq 10
    end
  end
end
