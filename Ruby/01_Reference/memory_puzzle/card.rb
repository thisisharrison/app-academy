class Card
    
    VALUES = ('A'..'Z').to_a

    def self.shuffled_pairs(num_pair)
        values = VALUES
        # grid is bigger than 26, extend the array of values 
        while num_pair > values.length
            values = values + values
        end
        # pairs creation, shuffle, take x items, double 
        pairs = values.shuffle.take(num_pair) * 2
        # mix it up again
        pairs.shuffle!
        # create Cards in an array
        pairs.map{ |card| self.new(card) }
    end

    attr_reader :value, :facing
    
    def initialize(value, face_up = false)
        @value = value
        @face_up = face_up # false = down, true = up
    end

    def hide
        @face_up = false
    end

    def reveal
        @face_up = true
    end
    
    def revealed?
        @face_up
    end

    def to_s
        @face_up ? value.to_s : " "
    end

    def ==(card)
        @value == card.value
    end

end
