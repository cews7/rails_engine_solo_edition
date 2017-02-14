require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "validates customer" do
    it {is_expected.to validate_presence_of(:first_name)}
    it {is_expected.to validate_presence_of(:last_name)}
  end
end
