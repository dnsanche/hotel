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
       @manager.reserve_room(Date.new(2019, 12, 5), Date.new(2019, 12, 1))
      }.must_raise ArgumentError
    end

    it "creates a reservation" do 
      reservation = @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 3))
      reservation.must_be_kind_of HotelBooking::Reservation
    end

    it "gets cost by reservation id" do 
      @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 3))
      expect @manager.get_cost(1).must_equal 400
    end

    it "gets reservation by date" do 
      reservation = @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 2))
      reservation2 = @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 3))
      expect @manager.get_reservation_by_date(Date.new(2019, 11, 30)).must_equal []
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 1))[0].must_equal reservation
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 1))[1].must_equal reservation2
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 1))[1].room.must_equal 2
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 1)).length.must_equal 2
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 2))[0].must_equal reservation2
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 2)).length.must_equal 1
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 3)).must_equal []
    end

    it "assigns correct room number" do 
      @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 2))
      @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 3))
      @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 3))
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 1))[0].room.must_equal 1
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 1))[1].room.must_equal 2
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 2))[0].room.must_equal 2
      expect @manager.get_reservation_by_date(Date.new(2019, 12, 2))[1].room.must_equal 3
    end

    it "shows available rooms for a given date range" do
      20.times do |reservation|
        @manager.reserve_room(Date.new(2019, 11, 10 ), Date.new(2019, 11, 13))
      end
      expect @manager.available_rooms(Date.new(2019, 11, 9), Date.new(2019, 11, 14)).must_equal []
      expect @manager.available_rooms(Date.new(2019, 11, 9), Date.new(2019, 11, 14)).must_equal []

      @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 2))
      @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 3))
      @manager.reserve_room(Date.new(2019, 12, 1), Date.new(2019, 12, 4))
      expect @manager.available_rooms(Date.new(2019, 12, 1), Date.new(2019, 12, 04)).count.must_equal 17
      expect @manager.available_rooms(Date.new(2019, 12, 10), Date.new(2019, 12, 11)).count.must_equal 20
    end

    it "raises exception if someone tries to do a reservation and there are no available rooms" do
      20.times do |reservation|
        @manager.reserve_room(Date.new(2019, 11, 10 ), Date.new(2019, 11, 13))
      end

      proc {
        @manager.reserve_room(Date.new(2019, 11, 10 ), Date.new(2019, 11, 13))
       }.must_raise ArgumentError

      
    end
  end
end
