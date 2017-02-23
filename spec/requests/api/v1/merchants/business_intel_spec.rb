require 'rails_helper'

RSpec.describe 'Merchant Business Intelligence' do
  it 'by default, returns top 2 merchants ranked by total revenue when given quantity' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant, name: "Tim")
    merchant_3 = create(:merchant, name: "John")

    merchant_1.invoices << create_list(:invoice, 2)
    merchant_2.invoices << create_list(:invoice, 2)
    merchant_3.invoices << create_list(:invoice, 2)

    merchant_1.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, unit_price: 100)
      invoice.invoice_items << create(:invoice_item, unit_price: 150, quantity: 2)
    end

    merchant_2.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, unit_price: 200)
      invoice.invoice_items << create(:invoice_item, unit_price: 250, quantity: 2)
    end

    merchant_3.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, unit_price: 300)
      invoice.invoice_items << create(:invoice_item, unit_price: 350, quantity: 2)
    end

    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_success

    top_merchants = JSON.parse(response.body, symbolize_names: true)

    expect(top_merchants.count).to eq 2
    expect(top_merchants.first).to have_value('John')
    expect(top_merchants.last).to have_value('Tim')
  end
end
