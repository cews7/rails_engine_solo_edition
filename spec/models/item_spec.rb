require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "item validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:unit_price) }
  end
end
