require 'rails_helper'

RSpec.describe Invoice, type: :request do
  it 'returns all invoices' do
    create_list(:invoice, 10)

    get '/api/v1/invoices'

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq 10
    expect(invoices.first.count).to eq 6
    expect(invoices.first).to have_key(:customer_id)
    expect(invoices.first).to have_key(:merchant_id)
    expect(invoices.first).to have_key(:status)
  end

  it 'returns all invoices -- customer_id lookup' do
    merchant       = create(:merchant)
    customer       = create(:customer, id: 1)
    invoice_clone1 = Invoice.create(id: 1, customer_id: customer.id, merchant_id: merchant.id, status: "success")
    invoice_clone2 = Invoice.create(id: 2, customer_id: customer.id, merchant_id: merchant.id, status: "success")
    invoice_uniq   = Invoice.create(id: 3, customer_id: 2, merchant_id: merchant.id, status: "success")

    get '/api/v1/invoices/find_all?customer_id=1'

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq 2
    expect(invoices.first).to have_key(:customer_id)
    expect(invoices.first).to have_key(:merchant_id)
  end

  it 'returns all invoices -- merchant_id lookup' do
    merchant       = create(:merchant, id: 1)
    merchant2      = create(:merchant)
    customer       = create(:customer)
    invoice_clone1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "success")
    invoice_clone2 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "success")
    invoice_uniq   = Invoice.create(customer_id: customer.id, merchant_id: merchant2.id, status: "success")

    get '/api/v1/invoices/find_all?merchant_id=1'

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq 2
    expect(invoices.first).to have_key(:customer_id)
    expect(invoices.first).to have_key(:merchant_id)
  end

  it 'returns all invoices -- status lookup' do
    merchant       = create(:merchant)
    customer       = create(:customer)
    invoice_clone1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "failed")
    invoice_clone2 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "success")
    invoice_uniq   = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "success")

    get '/api/v1/invoices/find_all?status=success'

    expect(response).to be_success

    invoices = JSON.parse(response.body, symbolize_names: true)

    expect(invoices.count).to eq 2
    expect(invoices.first).to have_key(:customer_id)
    expect(invoices.first).to have_key(:merchant_id)
  end

  it 'returns invoice -- id lookup' do
    db_invoice = create(:invoice)

    get "/api/v1/invoices/#{db_invoice.id}"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:status)
  end

  it 'returns invoice -- customer_id lookup' do
    db_invoice = create(:invoice)

    get "/api/v1/invoices/find?customer_id=#{db_invoice.customer_id}"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:status)
  end

  it 'returns invoice -- merchant_id lookup' do
    db_invoice = create(:invoice)

    get "/api/v1/invoices/find?merchant_id=#{db_invoice.merchant_id}"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:status)
  end

  it 'returns invoice -- status lookup' do
    db_invoice = create(:invoice)

    get "/api/v1/invoices/find?status=#{db_invoice.status}"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:status)
  end

  it 'returns invoice -- created_at lookup' do
    db_invoice = create(:invoice)

    get "/api/v1/invoices/find?created_at=#{db_invoice.created_at}"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:status)
  end

  it 'returns invoice -- updated_at lookup' do
    db_invoice = create(:invoice)

    get "/api/v1/invoices/find?updated_at=#{db_invoice.updated_at}"

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:status)
  end

  it 'returns random invoice' do
    create_list(:invoice, 10)

    get '/api/v1/invoices/random.json'

    expect(response).to be_success

    invoice_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(invoice_attrs.count).to eq 6
    expect(invoice_attrs).to have_key(:customer_id)
    expect(invoice_attrs).to have_key(:merchant_id)
    expect(invoice_attrs).to have_key(:status)
  end
end
