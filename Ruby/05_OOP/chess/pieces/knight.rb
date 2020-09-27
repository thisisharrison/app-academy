require_relative 'piece'
require_relative 'stepable'

class Knight < Piece 
    include Stepable

    def symbol
        '♞'.colorize(color)
    end

    protected
    # Protected methods can be invoked only by objects of the defining class and its subclasses.
    def move_diffs
        [[-2, -1],
        [-1, -2],
        [-2, 1],
        [-1, 2],
        [1, -2],
        [2, -1],
        [1, 2],
        [2, 1]]
    end
    
end