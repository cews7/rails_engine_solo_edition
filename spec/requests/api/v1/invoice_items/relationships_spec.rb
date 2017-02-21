require 'rails_helper'

RSpec.describe 'Invoice_items Relationships' do
  it 'returns the associated invoice' do
    merchant     = create(:merchant)
    customer     = create(:customer)
    invoice      = create(:invoice)
    item         = create(:item, merchant_id: merchant.id)
    invoice_item = create(:invoice_item, invoice_id: invoice.id, item_id: item.id)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id)
  end
end
