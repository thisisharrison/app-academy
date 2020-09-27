require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'

class MemoryGame 

    attr_accessor :previous_guess, :player

    def initialize(size = 4)
        @board = Board.new(size)
        @previous_guess = nil
        @player = ComputerPlayer.new(size)
    end

    def over
        @board.won?
    end

    def compare_guess(new_guess)
        if @previous_guess
            if match?(@previous_guess, new_guess)
                @player.receive_match(@player.previous_guess, new_guess)
            else
                puts "Try again!"
                [@player.previous_guess, new_guess].each { |pos| @board[pos].hide }
            end
            self.previous_guess = nil
            @player.previous_guess = nil
        else
            self.previous_guess = new_guess
            @player.previous_guess = new_guess
        end
    end

    def match?(pos_1, pos_2)
        @board[pos_1] == @board[pos_2]
    end

    def make_guess(new_guess)
        revealed_value = @board.reveal(new_guess)
        @player.receive_revealed_card(new_guess, revealed_value)
        @board.render
        compare_guess(new_guess)
        sleep(1)
        @board.render

    end

    def reveal_render(pos_1, pos_2='')
        @board.reveal(pos_1)
        @board.reveal(pos_2) if !pos_2.empty?
        @board.render
    end

    def play
        @board.render
        while !self.over
            
            new_guess = @player.get_input
            self.make_guess(new_guess)
        end
        puts "Game over"
    end
end

if __FILE__ == $PROGRAM_NAME
    g = MemoryGame.new()
    g.play
end