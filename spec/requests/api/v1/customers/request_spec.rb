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

  it 'returns all customers -- first_name lookup' do
    customer_clone1 = Customer.create(first_name: "John", last_name: "Doe")
    customer_clone2 = Customer.create(first_name: "John", last_name: "Doey")
    customer_uniq   = Customer.create(first_name: "Sam",  last_name: "Smith")

    get '/api/v1/customers/find_all?first_name=John'

    expect(response).to be_success

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers.count).to eq 2
    expect(customers.first).to have_key(:first_name)
    expect(customers.first).to have_key(:last_name)
    expect(customers.first).to have_value("John")
  end

  it 'returns all customers -- last_name lookup' do
    customer_clone1 = Customer.create(first_name: "John", last_name: "Doe")
    customer_clone2 = Customer.create(first_name: "John", last_name: "Doe")
    customer_uniq   = Customer.create(first_name: "Sam",  last_name: "Smith")

    get '/api/v1/customers/find_all?last_name=Doe'

    expect(response).to be_success

    customers = JSON.parse(response.body, symbolize_names: true)

    expect(customers.count).to eq 2
    expect(customers.first).to have_key(:first_name)
    expect(customers.first).to have_key(:last_name)
    expect(customers.first).to have_value("Doe")
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

  it 'returns customer -- created_at lookup' do
    db_customer = create(:customer)

    get "/api/v1/customers/find?created_at=#{db_customer.created_at}"

    expect(response).to be_success

    customer_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(customer_attrs.count).to eq 5
    expect(customer_attrs).to have_key(:first_name)
    expect(customer_attrs).to have_key(:last_name)
  end

  it 'returns customer -- updated_at lookup' do
    db_customer = create(:customer)

    get "/api/v1/customers/find?updated_at=#{db_customer.updated_at}"

    expect(response).to be_success

    customer_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(customer_attrs.count).to eq 5
    expect(customer_attrs).to have_key(:first_name)
    expect(customer_attrs).to have_key(:last_name)
  end

end
