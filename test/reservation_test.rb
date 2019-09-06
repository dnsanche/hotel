require_relative 'test_helper'
require "pry"

describe "Reservation" do
  describe "initialize" do

    it "is an instance of Reservation" do
      reservation = HotelBooking::Reservation.new("01/12/2019", "03/12/2019")
      reservation.must_be_kind_of HotelBooking::Reservation
    end

    it "raises argument error for invalid dates" do
      proc {
       HotelBooking::Reservation.new("10/12/2019", "01/12/2019")
      }.must_raise ArgumentError
    end

    it "is gives total cost" do
      reservation = HotelBooking::Reservation.new("01/12/2019", "03/12/2019")
      reservation.cost.must_equal 400
      reservation.id.must_equal 1
      reservation.room.must_equal 1
    end

  end
end