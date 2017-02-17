require 'rails_helper'

RSpec.describe Customer, type: :request do
  it 'returns all customers' do
    create_list(:customer, 10)

    get '/api/v1/customers'

    expect(response).to be_success

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers.count).to eq 10
    expect(customers.first.count).to eq 5
    expect(customers.first).to have_key(:first_name)
    expect(customers.first).to have_key(:last_name)
  end

  it 'returns customer -- id lookup' do
    db_customer = create(:customer)

    get "/api/v1/customers/#{db_customer.id}"

    expect(response).to be_success

    customer_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(customer_attrs.count).to eq 5
    expect(customer_attrs).to have_key(:first_name)
    expect(customer_attrs).to have_key(:first_name)
  end

  it 'returns customer -- first_name lookup' do
    db_customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{db_customer.first_name}"

    expect(response).to be_success

    customer_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(customer_attrs.count).to eq 5
    expect(customer_attrs).to have_key(:first_name)
    expect(customer_attrs).to have_key(:last_name)
  end

  it 'returns customer -- last_name lookup' do
    db_customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{db_customer.last_name}"

    expect(response).to be_success

    customer_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(customer_attrs.count).to eq 5
    expect(customer_attrs).to have_key(:first_name)
    expect(customer_attrs).to have_key(:last_name)
  end

end
