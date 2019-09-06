require_relative 'test_helper'
require "pry"

describe "Reservation" do
  describe "initialize" do

    it "is an instance of Reservation" do
      reservation = HotelBooking::Reservation.new("01/12/2019", "03/12/2019", "a", "a", "a")
      reservation.must_be_kind_of HotelBooking::Reservation
    end
  end
end