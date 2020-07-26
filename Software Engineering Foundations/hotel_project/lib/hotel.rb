require_relative "room"

class Hotel

    def initialize(name, hash) # eg of the hash "Basement"=>4, "Attic"=>2, "Under the Stairs"=>1
        @name = name
        @rooms = {}

        hash.each do |room, capacity|
            @rooms[room] = Room.new(capacity) # key = room name, value = room instance with capacity 
        end

    end
  
    def name
        @name.split(" ").map(&:capitalize).join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(name)
        @rooms.has_key?(name)

        # if @rooms[name]
        #     return true
        # else
        #     return false
        # end
    end

    def check_in(person, room)
        if !self.room_exists?(room)
            p 'sorry, room does not exist'
            return
        end

        room_obj = @rooms[room]
        success = room_obj.add_occupant(person) # returns true or false

        if success
            p 'check in successful'
            return true
        else
            p 'sorry, room is full'
            return false
        end
            
    end

    def has_vacancy?
        @rooms.values.any? { |room| !room.full? } # value = gets an array of Room instances # any not full = has vacancy 
    end

    def list_rooms
        
        @rooms.each { |room, obj| 
            puts "#{room} : #{obj.available_space}"
        }
        
    end

end
