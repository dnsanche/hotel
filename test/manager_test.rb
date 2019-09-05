require_relative 'test_helper'

describe "Manager class" do
  describe "initialize" do
    before do
      @manager = HotelBooking::Manager.new
    end

    it "has 20 rooms" do
      expect(@manager.list_rooms.length).must_equal 20
    end

    it "has rooms from 1 to 20" do
      (1..20).each do |number|
      expect(@manager.list_rooms[number-1]).must_equal number
      end
    end

  end
end
