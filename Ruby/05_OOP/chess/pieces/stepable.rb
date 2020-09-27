module Stepable
    def moves
    # move diffs from Knight and King 
    # each_with_object => list comprehension in ruby, in this case, moves is the end result array 
        move_diffs.each_with_object([]) do |(dx, dy), moves|
            curr_x, curr_y = pos
            pos = [curr_x + dx, curr_y + dy]
            
            next unless board.valid_pos?(pos)
            if board.empty?(pos)
                moves << pos
            # color will come from piece classes
            elsif board[pos].color != color
                # we can take an opponent's piece
                moves << pos
            end
        end
    end

    private
    def move_diffs
        raise NotImplementedError
    end
end
