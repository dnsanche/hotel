require_relative 'test_helper'
require "pry"

describe "Booking class" do
  describe "initialize" do
    before do
      @booking = HotelBooking::Booking.new(
        start_date = Date.parse("01/12/2019"), 
        end_date = Date.parse("03/12/2019")
      )

      @booking2 = HotelBooking::Booking.new(
        start_date = Date.parse("20/12/2019"), 
        end_date = Date.parse("01/12/2019")
      )

    end

    it "is an instance of Booking" do
      expect(@booking).must_be_kind_of HotelBooking::Booking
    end
    
    it "calculates total nights" do
      expect(@booking.total_nights).must_equal 2
    end

    it "calculates total cost" do
      expect(@booking.total_cost).must_equal 400
    end

    it "raises argument error for invalid dates" do
      expect{@booking2.valid_dates}.must_raise ArgumentError
    end
  end
end