require 'rails_helper'

RSpec.describe TicketOrder, :type => :model do
  it 'has a valid factory' do
    expect(build(:ticket_order)).to be_valid
  end

  context "when there are model methods" do
    it "returns a ticket order cc number in **** **** **** 1234 format" do
      ticket_order = build(:ticket_order)

      expect(ticket_order.starred_cc_number).to eq("**** **** **** 5820")
    end 

    it "returns a ticket order cc expiration date in 10/2018 format" do
      ticket_order = build(:ticket_order,
        expiration_date: Date.new(2018,10,29)
      )

      expect(ticket_order.cc_expiration_date).to eq("10/2018")
    end 

    it "returns a ticket order date in Oct 29, 2016 - 10:00 AM format" do
      ticket_order = build(:ticket_order,
        created_at: DateTime.new(2016,10,29,10,00,00)
      )

      expect(ticket_order.order_date).to eq("Oct 29, 2016 - 10:00 AM")
    end

    it "returns ticket orders in ascending created_at date order" do
      ticket_order_newer = create(:ticket_order,
        created_at: DateTime.new(2016,10,29,10,00,00)
      )

      ticket_order_older = create(:ticket_order,
        created_at: DateTime.new(2016,10,28,10,00,00)
      )

      expect(TicketOrder.order_date_asc.last).to eq(ticket_order_newer)
    end

    it "returns ticket orders in descending created_at date order" do
      ticket_order_newer = create(:ticket_order,
        created_at: DateTime.new(2016,10,29,10,00,00)
      )

      ticket_order_older = create(:ticket_order,
        created_at: DateTime.new(2016,10,28,10,00,00)
      )

      expect(TicketOrder.order_date_desc.last).to eq(ticket_order_older)
    end

    it "returns error 'is in the past and no longer available for purchase' for ticket order where ticket_date < Date.today" do
      ticket_order = build(:ticket_order,
        ticket_date: Date.new(2016,10,20)
      )
      ticket_order.valid?

      expect(ticket_order.errors[:ticket_date]).to include("is in the past and no longer available for purchase")
    end

    it "returns error 'can't be in the past' for ticket order where cc expiration_date < Date.today" do
      ticket_order = build(:ticket_order,
        expiration_date: Date.new(2016,10,20)
      )
      ticket_order.valid?

      expect(ticket_order.errors[:expiration_date]).to include("can't be in the past")
    end
  end
end