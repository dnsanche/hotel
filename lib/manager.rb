require_relative 'reservation'
require 'pry'

module HotelBooking
  class Manager
    COST = 200

    def initialize
      @rooms = []
      (1..20).each do |room_number|
        @rooms << room_number
      end
      @rooms.freeze 
      @id = 0
      @reservation_by_id = {}
      @reservations_by_date = {}
    end

    def list_rooms
      return @rooms
    end
    
    def reserve_room(check_in , check_out)  
      id = get_next_id
      room = get_available_room(check_in , check_out)
      cost = ((check_out - check_in).to_i) * COST
      reservation = Reservation.new(check_in, check_out, id, room, cost) 
      @reservation_by_id.store(id,reservation)
      (check_in...check_out).each do |date|
        if @reservations_by_date.has_key?(date) == false
          reservations = []
          reservations << reservation
          @reservations_by_date.store(date, reservations)
        else
          @reservations_by_date[date] << reservation
        end
      end
      return reservation
    end

    def get_reservation_by_date(date)
      if @reservations_by_date[date] != nil
        result = @reservations_by_date[date]
      else
        result = []
      end
      return result
    end

    def get_cost(id)
      return @reservation_by_id[id].cost 
    end
      
  private
    def get_next_id
      return  @id += 1
    end

    def get_available_room(check_in, check_out)
      return  @rooms.first
    end

  end
end









