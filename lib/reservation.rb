require 'date'

COST = 200

module HotelBooking
  class Reservation
    def initialize (id,start_date, end_date, cost, room)
      @id = id
      
      @start_date = start_date
      @end_date = end_date
    end

    def valid_dates
      unless @end_date > @start_date 
        raise ArgumentError.new("Invalid Dates")
      end
    end

    def total_nights
      return @end_date - @start_date 
    end

    def total_cost
      return total_nights * COST
    end
  end
end

