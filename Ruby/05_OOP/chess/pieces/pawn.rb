require_relative 'piece'

class Pawn < Piece 

    def symbol
        '♟'.colorize(color)
    end

    def moves
        forward_steps + side_attacks
    end

    private

    def at_start_row?
        # the row number for white is 6, black is 1
        row, col = pos
        
        row == (color == :white ? 6 : 1)
    end

    def forward_dir
        # going up (-1) if white, down (+1) if black
        color == :white ? -1 : 1
    end

    def forward_steps
        row, col = pos
        one_step = [row + forward_dir, col]
        return [] unless board.empty?(one_step) && board.valid_pos?(one_step)

        steps = [one_step]
        
        # can do two steps if at start row 
        two_steps = [row + 2 * forward_dir, col]
        steps << two_steps if at_start_row? && board.empty?(two_steps)

        steps
    end

    def side_attacks
        row, col = pos
        
        side_moves = [[row + forward_dir, col - 1], [row + forward_dir, col + 1]]
        
        side_moves.select do |new_pos|
            next false unless board.valid_pos?(new_pos)
            next false if board.empty?(new_pos)

            enemy = board[new_pos]

            # there is a piece and the color is not our color
            enemy && enemy.color != color
        end
        
    end
end