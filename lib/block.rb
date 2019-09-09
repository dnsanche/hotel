require 'date'

module HotelBooking
  class Block
    attr_reader :check_in, :check_out, :rooms, :discounted_rate

    def initialize(check_in, check_out, rooms = [], discounted_rate)     
      @check_in = check_in
      @check_out = check_out
      @rooms = rooms
      @discounted_rate = discounted_rate
    end
  end
end

