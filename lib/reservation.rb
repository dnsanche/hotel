require 'date'

module HotelBooking
  class Reservation
    attr_reader :check_in, :check_out, :id, :room, :cost

    def initialize(check_in, check_out, id, room, cost)     
      validate_dates(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
      @id = id
      @room = room
      @cost = cost
    end

    private
    def validate_dates(check_in, check_out)
      unless check_out > check_in
        raise ArgumentError.new("Invalid dates") 
      end
    end

  end
end

