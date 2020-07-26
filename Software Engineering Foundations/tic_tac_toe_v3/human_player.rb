class HumanPlayer

    attr_reader :mark

    def initialize(mark)
        @mark = mark
    end

    def get_position(legal_positions)
        pos = nil
        until legal_positions.include?(pos)
            puts "Player #{@mark} enter position in the format 'row col'"
            pos = gets.chomp.split(" ").map(&:to_i)
            puts "#{pos} is not a valid position" if !legal_positions.include?(pos)
            raise 'Invalid position' if pos.length != 2 
        end
        pos
    end
end
