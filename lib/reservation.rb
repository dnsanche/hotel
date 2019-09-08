require 'date'

module HotelBooking
  class Reservation
    attr_reader :check_in, :check_out, :id, :room, :cost

    def initialize(check_in, check_out, id, room, cost)     
      @check_in = check_in
      @check_out = check_out
      @id = id
      @room = room
      @cost = cost
    end

  end
end

