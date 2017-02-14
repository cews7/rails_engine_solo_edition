FactoryGirl.define do
  factory :item do
    name "Sol Ring"
    description "Add two mana to mana pool"
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
    unit_price 1
  end

  factory :customer do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end
end
