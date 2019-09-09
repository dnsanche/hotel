require_relative 'reservation'
require_relative 'block'
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
      @blocks_by_date = {}
    end

    def list_rooms
      return @rooms
    end

    def reserve_room(check_in , check_out)  
      validate_dates(check_in, check_out)
      room = available_rooms(check_in, check_out).first   
      id = get_next_id
      cost = ((check_out - check_in).to_i) * COST
      reservation = Reservation.new(check_in, check_out, id, room, cost) 
      (check_in...check_out).each do |date|
        if @reservations_by_date.has_key?(date) == false
          reservations = []
          reservations << reservation
          @reservations_by_date.store(date, reservations)
          @reservation_by_id.store(id,reservation)
        else
            @reservations_by_date[date] << reservation
            @reservation_by_id.store(id,reservation)
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

    def available_rooms(check_in, check_out)  
      available_rooms = Array.new(20, true)
      (check_in...check_out).each do |date|
        if @reservations_by_date[date] != nil
          @reservations_by_date[date].each do |reservation|
            available_rooms[reservation.room - 1] = false
          end
        end
        if @blocks_by_date[date] != nil
          @blocks_by_date[date].each do |block|
            block.rooms.each do |room|
              available_rooms[room - 1] = false
            end
          end
        end
      end  
      if available_rooms.include?(true) == true
        available_rooms = available_rooms.each_index.select { |index| available_rooms[index] == true} 
        available_rooms.map! do |index|
          index + 1
        end 
      else 
        raise ArgumentError.new("No available room")
      end 
      return available_rooms
    end

    def get_rooms_in_block(check_in, check_out)
      if @blocks_by_date[check_in] != nil
        @blocks_by_date[check_in].each do |block|
          block.rooms
        end
      else
         raise ArgumentError.new("Invalid block")
      end
    end

    def create_block(check_in , check_out, num_rooms, discounted_rate)
      validate_dates(check_in, check_out)
      validate_less_6_rooms(num_rooms)

      if available_rooms(check_in, check_out).count >= num_rooms
        rooms = []
        num_rooms.times do |index|
          rooms << available_rooms(check_in, check_out)[index]
        end
      else
        raise ArgumentError.new("No available room")
      end
      block = Block.new(check_in, check_out, rooms, discounted_rate)
      (check_in...check_out).each do |date|
        if @blocks_by_date.has_key?(date) == false
          blocks = []
          blocks << block
          @blocks_by_date.store(date, blocks)
        else
          @blocks_by_date[date] << block
        end
      end
      return block
    end

  private
    def get_next_id
      return  @id += 1
    end
    
    def validate_dates(check_in, check_out)
      unless check_out > check_in
        raise ArgumentError.new("Invalid dates") 
      end
    end

    def  validate_less_6_rooms(num_rooms)
      unless num_rooms <= 5
        raise ArgumentError.new("A block can contain a maximum of 5 rooms")
      end
    end    
  end
end