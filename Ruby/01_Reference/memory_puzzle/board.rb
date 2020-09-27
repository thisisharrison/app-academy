require_relative 'card'

class Board
    def initialize(size = 4)
        @grid = Array.new(size) { Array.new(size) }
        @size = size
        populate
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @grid[row][col] = value
    end

    def populate
        num_pairs = @size**2 / 2
        pairs = Card.shuffled_pairs(num_pairs)
        (0...@size).each do |row|
            (0...@size).each do |col|
                self[[row,col]] = pairs.pop
            end
        end
    end
    
    def render
        system("clear")
        print "  " + (0...@size).to_a.join(" ") + "\n"
        @grid.each_with_index do |row, i|
            puts "#{i.to_s + " " + row.map(&:to_s).join(' ')}"
        end
    end

    def won?
        (0...@size).all? do |row|
            (0...@size).all? do |col|
                self[[row,col]].revealed?
            end
        end
    end

    def reveal(pos)
        if revealed?(pos)
            puts "You can't flip a card that's been flipped"
        else
            self[pos].reveal
        end
        self[pos].value
    end

    def revealed?(pos)
        self[pos].revealed?
    end
end
