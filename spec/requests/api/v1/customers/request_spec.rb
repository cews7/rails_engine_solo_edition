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
end
