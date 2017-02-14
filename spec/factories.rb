FactoryGirl.define do
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
