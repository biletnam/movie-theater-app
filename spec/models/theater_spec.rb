require 'rails_helper'

RSpec.describe Theater, :type => :model do
  it 'has a valid factory' do
    expect(build(:theater)).to be_valid
  end

  context "when there are model methods" do
    it "returns a theater's full address" do
      theater = build(:theater, 
        street_address: "123 Main Street", 
        city: "Chicago",
        state: "IL",
        zip: "60601"
      )
      expect(theater.full_address).to eq("123 Main Street \nChicago, IL 60601")
    end 
  end
end