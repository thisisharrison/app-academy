module Slideable
    # Rook, Bishop, Queen
    # freeze makes you unable to change the array
    HORIZONTAL_AND_VERTICAL_DIRS = [
        # up
        [-1, 0],
        # left
        [0, -1],
        # right
        [0, 1],
        # down
        [1, 0]
    ].freeze

    DIAGONAL_DIRS = [
        # SW
        [-1, -1],
        # NW
        [-1, 1],
        # SE
        [1, -1],
        # NE
        [1, 1]
    ].freeze

    def horizontal_dirs
        HORIZONTAL_AND_VERTICAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        # array of pos piece can take
        moves = []

        # directions which the piece can move
        move_dir.each do |dx, dy|
            # method returns an array, combine the array with concat
            moves.concat(grow_unblocked_moves_in_dir(dx, dy))
        end

        moves
    end

    private 

    def move_dir
        # encounters a reference to a method that cannot be executed within the current system environment
        # move_dir will be determined by pieces 
        raise NotImplementedError
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        # current pos
        curr_x, curr_y = pos
        moves = []

        # same as while loop but conditional checks happens inside the loop (with #break)
        loop do
            curr_x, curr_y = curr_x + dx, curr_y + dy
            pos = [curr_x, curr_y]

            break unless board.valid_pos?(pos)
            
            if board.empty?(pos)
                moves << pos
            # color will come from piece classes
            else
                # we can take an opponent's piece
                moves << pos if board[pos].color != color
                # we're blocked
                break
            end
        end

        moves
    end
end