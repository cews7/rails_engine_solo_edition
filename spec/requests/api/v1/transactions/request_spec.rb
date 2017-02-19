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

  it 'returns transaction -- credit_card_number lookup' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_number=#{db_transaction.credit_card_number}"

    expect(response).to be_success

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction.count).to eq 6
    expect(transaction).to have_key(:invoice_id)
    expect(transaction).to have_key(:credit_card_number)
  end

  it 'returns transaction -- result lookup' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?result=#{db_transaction.result}"

    expect(response).to be_success

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction.count).to eq 6
    expect(transaction).to have_key(:invoice_id)
    expect(transaction).to have_key(:credit_card_number)
  end

  it 'returns transaction -- created_at lookup' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?created_at=#{db_transaction.created_at}"

    expect(response).to be_success

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction.count).to eq 6
    expect(transaction).to have_key(:invoice_id)
    expect(transaction).to have_key(:credit_card_number)
  end

  it 'returns transaction -- updated_at lookup' do
    db_transaction = create(:transaction)

    get "/api/v1/transactions/find?updated_at=#{db_transaction.updated_at}"

    expect(response).to be_success

    transaction = JSON.parse(response.body, symbolize_names: true)

    expect(transaction.count).to eq 6
    expect(transaction).to have_key(:invoice_id)
    expect(transaction).to have_key(:credit_card_number)
  end

  it 'returns random transaction' do
    create_list(:transaction, 10)

    get '/api/v1/transactions/random.json'

    expect(response).to be_success

    transaction_attrs = JSON.parse(response.body, symbolize_names: true)

    expect(transaction_attrs.count).to eq 6
    expect(transaction_attrs).to have_key(:invoice_id)
    expect(transaction_attrs).to have_key(:credit_card_number)
  end

end
