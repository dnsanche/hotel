require_relative 'reservation'

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

    def get_cost(id)
      return @reservation_by_id[id].cost 
    end

    def get_reservation_by_date(date)
      reservation_by_date = @reservations_by_date[date].duplicate
      return reservation_by_date
    end
      
    def reserve_room(check_in , check_out)
      id = get_next_id
      room = get_available_room(check_in, check_out)
      cost = (check_out - check_in) * COST
      reservation = Reservation.new(check_in, check_out, id, room, cost) 
      @reservation_by_id.store(id,reservation)
      @reservation_by_date.store()
      return reservation
    end

  private
    def get_next_id
      return  @id +=1
    end

    def get_available_room(check_in, check_out)
      return  @rooms.first
    end
  end
end









