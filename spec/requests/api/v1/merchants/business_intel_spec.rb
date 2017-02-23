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

  it 'by default, returns top 2 merchants based on number of items sold' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant, name: "Tim")
    merchant_3 = create(:merchant, name: "John")

    merchant_1.invoices << create_list(:invoice, 2)
    merchant_2.invoices << create_list(:invoice, 2)
    merchant_3.invoices << create_list(:invoice, 2)

    merchant_1.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 10)
      invoice.invoice_items << create(:invoice_item, quantity: 20)
    end

    merchant_2.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 30)
      invoice.invoice_items << create(:invoice_item, quantity: 40)
    end

    merchant_3.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 50)
      invoice.invoice_items << create(:invoice_item, quantity: 60)
    end

    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_success

    top_merchants = JSON.parse(response.body, symbolize_names: true)

    expect(top_merchants.count).to eq 2
    expect(top_merchants.first).to have_value('John')
    expect(top_merchants.last).to have_value('Tim')
  end

  it 'returns total revenue for merchant across all transactions' do
    merchant_1 = create(:merchant)

    merchant_1.invoices << create_list(:invoice, 2)

    merchant_1.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 1, unit_price: 5)
      invoice.invoice_items << create(:invoice_item, quantity: 1, unit_price: 5)
    end

    get "/api/v1/merchants/#{merchant_1.id}/revenue"

    expect(response).to be_success
    expect(response.body).to eq '{"revenue":"0.2"}'
  end

  it 'returns total revenue for merchant for specific invoice date' do
    merchant_1 = create(:merchant)

    merchant_1.invoices << create_list(:invoice, 2)

    merchant_1.invoices.each do |invoice|
      invoice.transactions  << create(:transaction)
      invoice.invoice_items << create(:invoice_item, quantity: 1, unit_price: 5)
      invoice.invoice_items << create(:invoice_item, quantity: 1, unit_price: 5)
    end

    get "/api/v1/merchants/#{merchant_1.id}/revenue?date=#{merchant_1.invoices.first.created_at}"

    expect(response).to be_success
    expect(response.body).to eq '{"revenue":"0.4"}'
  end

  it 'returns customer who has conducted most total number of successful transactions' do
    merchant     = create(:merchant)
    fav_customer = create(:customer)
    customer     = create(:customer)
    invoices     = create_list(:invoice, 2, merchant: merchant, customer: fav_customer)
    invoice      = create(:invoice, merchant: merchant, customer: customer)
    create(:transaction, result: 'success', invoice: invoices.first)
    create(:transaction, result: 'success', invoice: invoices.last)
    create(:transaction, result: 'success', invoice: invoice)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(response).to be_success

    customer = JSON.parse(response.body)

    expect(customer['id']).to eq(fav_customer.id)
  end
end
