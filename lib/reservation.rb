require 'date'

module HotelBooking
  class Reservation
    attr_reader :check_in, :check_out, :id, :room, :cost

    def initialize (check_in, check_out, id, room, cost)
      start_date = Date.parse(check_in)
      end_date = Date.parse(check_out)
      unless start_date < end_date
        raise ArgumentError.new("Invalid dates") 
      end
     
      @check_in = start_date
      @check_out = end_date
      @id = id
      @room = room
      @cost = cost
    end
  end
end

