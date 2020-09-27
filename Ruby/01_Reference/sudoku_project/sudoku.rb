require_relative 'board'
require "byebug"

class SudokuGame
    
    def self.from_file(filename)
        board = Board.from_file(filename)
        self.new(board)
    end

    attr_reader :board

    def initialize(board)
        @board = board
    end

    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            puts "Enter position (eg. 0,0)"
            pos = parse_pos(gets.chomp)
        end
        pos
    end

    def get_val
        val = nil
        until val && valid_val?(val)
            puts "Enter value"
            val = parse_val(gets.chomp)
        end
        val
    end

    def parse_pos(string)
        string.split(',').map(&:to_i)
    end

    def parse_val(string)
        Integer(string)
    end

    def play_turn
        @board.render
        # debugger
        pos = self.get_pos
        val = self.get_val
        @board[pos] = val
    end

    def run
        while !self.solved?
            # debugger
            self.play_turn
        end
        @board.render
        puts "You win!"
    end

    def solved?
        @board.solved?
    end

    def valid_pos?(pos)
        pos.length == 2 &&
        pos.is_a?(Array) &&
        pos.all? {|el| el.between?(0,8)}
    end

    def valid_val?(val)
        val.is_a?(Integer) &&
        val.between?(0,9)
    end

end

if __FILE__ == $PROGRAM_NAME
    g = SudokuGame.from_file('./puzzles/sudoku1.txt')
    g.run
end