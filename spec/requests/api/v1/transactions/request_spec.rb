require 'rails_helper'

RSpec.describe Transaction, type: :request do
  it 'returns all transactions' do
    create_list(:transaction, 10)

    get '/api/v1/transactions'

    expect(response).to be_success

    transactions = JSON.parse(response.body, symbolize_names: true)

    expect(transactions.count).to eq 10
    expect(transactions.first.count).to eq 6
    expect(transactions.first).to have_key(:invoice_id)
    expect(transactions.first).to have_key(:credit_card_number)
  end
end
