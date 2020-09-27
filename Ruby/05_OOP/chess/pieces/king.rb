require_relative 'piece'
require_relative 'stepable'

class King < Piece 
    include Stepable

    def symbol
        '♚'.colorize(color)
    end

    protected
    # Protected methods can be invoked only by objects of the defining class and its subclasses.
    def move_diffs
        [[-1, -1],
        [-1, 0],
        [-1, 1],
        [0, -1],
        [0, 1],
        [1, -1],
        [1, 0],
        [1, 1]]
    end

end