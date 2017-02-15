FactoryGirl.define do
  factory :transaction do
    invoice_id 1
    credit_card_number Faker::Business.credit_card_number
    result "success"
  end
  factory :merchant do
    name Faker::LordOfTheRings.character
  end
  factory :item do
    name Faker::Commerce.product_name
    description Faker::Hipster.sentence
    unit_price 1
    merchant_id 1
  end
  factory :invoice do
    customer_id 1
    merchant_id 1
    status "shipped"
  end
  factory :invoice_item do
    item_id 1
    invoice_id 1
    quantity 1
    unit_price Faker::Commerce.price
  end

  factory :customer do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end
end
