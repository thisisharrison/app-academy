require_relative 'tile'

class Board
    
    def self.empty_grid
        Array.new(9) {
            Array.new(9) { 
                Tile.new(0) 
            }
        }
    end

    def self.from_file(filename)
        file_data = File.readlines(filename).map(&:chomp)
        tiles = file_data.map do |row|
            nums = row.split("").map {|char| Integer(char)}
            nums.map { |value| Tile.new(value) }
        end
        self.new(tiles)
    end
    
    attr_reader :grid

    def initialize(grid = Board.empty_grid)
        @grid = grid
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @grid[row][col].value = value
    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        @grid.each_with_index do |row, i|
            puts "#{i.to_s} #{row.join(" ")}"
        end
    end

    def solved_set(tiles)
        nums = tiles.map(&:value)
        nums.sort == (1..9).to_a
    end

    def row_solved?
        @grid.all? do |row|
            solved_set(row)
        end
    end

    def col_solved?
        @grid.transpose.all? do |col|
            solved_set(col)
        end
    end

    def squares
        # 9 x 9 grid has 9 squares of 3 x 3
        x = (0..8).to_a.map {|i| square(i)}
        print x[1]
        return x
    end

    def square(idx)
        tiles = []
        # (0 / 3) * 3 == 0, (1 / 3) * 3 == 0, (2 / 3) * 3 == 0
        # (0 % 3) * 3 == 0, (1 % 3) * 3 == 3, (2 % 3) * 3 == 6 => segmenting the 3 x 3 squares 
        # debugger
        row = (idx / 3) * 3
        col = (idx % 3) * 3

        (row...row+3).each do |i|
            (col...col+3).each do |j|
                tiles << self[[i,j]]
            end
        end
        tiles
    end

    def solved?
        row_solved? &&
        col_solved? &&
        squares.all? {|square| solved_set(square)}
    end
end
