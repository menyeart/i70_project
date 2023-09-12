require 'rails_helper'

describe SkiArea, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location_id) }
  end
end