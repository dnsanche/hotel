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
    
    def check_in_to_date(check_in)
      start_date = Date.parse(check_in)
      return start_date
    end

    def check_out_to_date(check_out)
      end_date = Date.parse(check_out)
      return end_date
    end

    def date_range(check_in, check_out)
      date_range = check_in_to_date(check_in)...check_out_to_date(check_out)
      return date_range
    end

    def validate_dates(check_in, check_out)
      unless check_out_to_date(check_out) > check_in_to_date(check_in)
        raise ArgumentError.new("Invalid dates") 
      end
    end

    def duration(check_in, check_out)
      duration = check_out_to_date(check_out) - check_in_to_date(check_in)
      return duration.to_i
    end

    def reserve_room(check_in , check_out)
      validate_dates(check_in, check_out)
    
      id = get_next_id
      room = get_available_room(check_in , check_out)
      cost = duration(check_in, check_out) * COST
      reservation = Reservation.new(check_in, check_out, id, room, cost) 
      @reservation_by_id.store(id,reservation)
      return reservation
    end

    def get_cost(id)
      return @reservation_by_id[id].cost 
    end

    
      
      # date_range(check_in, check_out).each do |date|
      #   if @reservations_by_date.has_key?(date) == false
      #     reservations = []
      #     reservations << reservation
      #     @reservations_by_date.store(date, reservations)
      #   else
      #     @reservations_by_date.has_key?(date) == true
      #     @reservations_by_date[date] << reservation
      #   end
      # end
  
   
    # def get_reservation_by_date(date)
    #   reservation_by_date = @reservations_by_date[date].duplicate
    #   return reservation_by_date
    # end
      
  private
    def get_next_id
      return  @id += 1
    end

    def get_available_room(check_in, check_out)
      return  @rooms.first
    end

  end
end









