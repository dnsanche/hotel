require_relative 'test_helper'

describe "Block" do
  describe "initialize" do

    it "is an instance of Block" do
      block = HotelBooking::Block.new("01/12/2019", "03/12/2019", 3, 150)
      block.must_be_kind_of HotelBooking::Block
    end
  end
end