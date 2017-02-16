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

  it 'returns transaction -- id lookup' do
     db_transaction = create(:transaction)

     get "/api/v1/transactions/#{db_transaction.id}"

     expect(response).to be_success

     transaction = JSON.parse(response.body, symbolize_names: true)

     expect(transaction.count).to eq 6
     expect(transaction).to have_key(:invoice_id)
     expect(transaction).to have_key(:credit_card_number)
  end

  it 'returns transaction -- invoice_id lookup' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?invoice_id=#{db_transaction.invoice_id}"

    expect(response).to be_success

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction.count).to eq 6
    expect(transaction).to have_key(:invoice_id)
    expect(transaction).to have_key(:credit_card_number)
  end
end
