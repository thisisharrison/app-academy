require './board.rb'
require './human_player.rb'
require './computer_player.rb'

class Game
    def initialize(size, players)
        @players = players.map do |mark, is_computer| 
            is_computer ? ComputerPlayer.new(mark) : HumanPlayer.new(mark)
        end
        @current_player = @players.first
        @board = Board.new(size)
    end

    def switch_turn
        @players.rotate!(1)
        @current_player = @players.first
    end

    def play
        while @board.empty_positions?
            @board.print
            choices = @board.legal_positions
            pos = @current_player.get_position(choices)
            @board.place_mark(pos, @current_player.mark)
            if @board.win?(@current_player.mark)
                @board.print 
                puts 'Game Over'
                puts "Player #{@current_player.mark} has won!"
                return
            else
                self.switch_turn
            end
        end
        puts "Game Over"
        puts "Draw"
    end
end

 