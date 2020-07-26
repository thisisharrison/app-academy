class ComputerPlayer

    attr_reader :mark
    
    def initialize(mark)
        @mark = mark
    end

    def get_position(legal_positions)
        pos = legal_positions.sample
        row, col = pos
        puts "Computer #{@mark} picked position #{row} #{col}" 
        pos
    end
end