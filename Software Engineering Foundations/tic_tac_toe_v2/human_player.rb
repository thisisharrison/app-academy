class HumanPlayer

    attr_reader :mark

    def initialize(mark)
        @mark = mark
    end

    def get_position
        puts "Player #{@mark} enter position in the format 'row col'"
        pos = gets.chomp.split(" ").map(&:to_i)
        raise 'Invalid position' if pos.length != 2 
        pos
    end
end
