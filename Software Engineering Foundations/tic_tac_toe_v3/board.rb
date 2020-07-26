class Board
    def initialize(n)
        @grid = Array.new(n) {Array.new(n,"_")}
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

    def legal_positions
        indices = (0...@grid.length).to_a
        positions = indices.product(indices)
        positions.select {|pos| empty?(pos)}
    end
end

# Array#product() : return all combinations of all arrays 

