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

    it "raises argument error for invalid dates" do
      proc {
       @manager.reserve_room("02/12/2019", "01/12/2019")
      }.must_raise ArgumentError
    end

    it "creates a reservation" do 
      reservation = @manager.reserve_room("01/12/2019", "03/12/2019")
      reservation.must_be_kind_of HotelBooking::Reservation
    end

    it "gets cost by reservation id" do 
      reservation = @manager.reserve_room("01/12/2019", "03/12/2019")
      expect @manager.get_cost(1).must_equal 400
    end


    # it "is gives total cost" do
    #   reservation = HotelBooking::Reservation.new("01/12/2019", "03/12/2019")
    #   reservation.cost.must_equal 400
    #   reservation.id.must_equal 1
    #   reservation.room.must_equal 1
    # end


  end
end
