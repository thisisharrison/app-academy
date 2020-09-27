require "colorize"

class Piece
    attr_reader :color, :board
    attr_accessor :pos

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos

        board.add_piece(self, pos)
    end

    def to_s 
        " #{symbol}"
    end

    def empty?
        false
    end

    def symbol
        raise NotImplementedError
    end

    def valid_moves
        # return if there's any moves left that is not into check
        moves.reject { |end_pos| move_into_check?(end_pos) }
    end

    def move_into_check?(end_pos)
        dup_board = board.dup
        # move every piece type to their possible end_pos
        dup_board.move_piece!(pos, end_pos)
        # is board not in_check?
        dup_board.in_check?(color)
    end
end
