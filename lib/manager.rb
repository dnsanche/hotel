module HotelBooking
  class Manager
    def initialize
      @rooms = []
      (1..20).each do |room_number|
        @rooms << room_number
      end
      @rooms.freeze
    end
  
    def list_rooms
      return @rooms
    end 

    def reserve_room(start_date, end_date)
      reservation = 
    end  

  end 
end 







