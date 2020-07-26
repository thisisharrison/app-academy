class Board
    def initialize
        @grid = Array.new(3) {Array.new(3,"_")}
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @grid[row][col] = value
    end

    def valid?(pos)
        row, col = pos
        pos.all? {|i| i >= 0 && i < @grid.length}
    end

    def empty?(pos)
        self[pos] == "_"
    end

    def place_mark(pos, mark)
        raise 'Invalid position and mark' if !self.empty?(pos) || !self.valid?(pos)
        self[pos] = mark
    end

    def print
        @grid.each {|row| puts row.join(" ")}
    end

    def win_row?(mark)
        @grid.any?{|row| row.all?(mark)}
    end

    def win_col?(mark) 
        @grid.transpose.any?{|row| row.all?(mark)}
    end

    def win_diagonal?(mark)
        right_to_left = (0...@grid.length).all? {|i| @grid[i][i] == mark}
        left_to_right = (0...@grid.length).all? do |i|
            pos = [i, (@grid.length - 1 - i)]
            self[pos] == mark
        end
        right_to_left || left_to_right
    end

    def win?(mark)  
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.any?{|row| row.any?{|ele| ele == "_"}} 
    end
end

# array decomposition 
# row, col = [0, 0] 
# row = 0, col = 0
# another example: 
# a, (b, *c), *d = 1, [2, 3, 4], 5, 6
# p a: a, b: b, c: c, d: d
# prints {:a=>1, :b=>2, :c=>[3, 4], :d=>[5, 6]}

# syntatic sugar
# self#[]: board.[]([0,0]) => b[[0,0]] => pos = [0,0] => self[pos] 
# self#[]=: board.[]=([0,0],:X) => b[[0,0]]=:X => self[pos]=