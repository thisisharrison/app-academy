class Board

    attr_accessor :size    
  
    def self.print_grid(board)
        board.each do |row|
            puts row.join(" ") # difference between p, puts and print: p is inspect, puts give us \n, print has no \n
        end
    end

    def initialize(n)
        @grid = Array.new(n) {Array.new(n, :N)}
        @size = n * n
    end

    def [](position)
        row, col = position # state two variables at once and take array assigning to multiple vars 
        # row = position[0]
        # column = position[1]

        @grid[row][col]
    end

    def []=(position, value)
        row, col = position

        @grid[row][col] = value
    end

    def num_ships 
        @grid.flatten.count {|ele| ele == :S}
    end

    def attack(position)
        if self[position] == :S # self: defined [] on the Board class, self is an instance of board 
            self[position] = :H
            p 'you sunk my battleship!'
            return true
        else
            self[position] = :X
            return false
        end
    end

    def place_random_ships
        max_ships = @size * 0.25
        
        while self.num_ships < max_ships # count num of ships as we place max amount of ships
            row = rand(0...@grid.length)
            col = rand(0...@grid.length) # exclude length index as out of range
            pos = [row, col]
            self[pos] = :S 
        end
    
    end

    def hidden_ships_grid
        @grid.map do |row|
            row.map do |ele|
                if ele == :S
                    :N
                else
                    ele
                end
            end
        end

        # hidden = []

        # @grid.each do |row|
        #     hidden_row = []
        #     row.each do |col|
        #         if col == :S
        #             hidden_row << :N
        #         else
        #             hidden_row << col
        #         end
        #     end
        #     hidden << hidden_row
        # end

        # hidden
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(self.hidden_ships_grid) # need self here because hidden_ships_grid is a method of Board instance
    end

end
