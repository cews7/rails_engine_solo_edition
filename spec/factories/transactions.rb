FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number Faker::Business.credit_card_number
    result "success"
  end
end
