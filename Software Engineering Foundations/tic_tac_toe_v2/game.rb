require './board.rb'
require './human_player.rb'

class Game
    def initialize(size, *marks)
        @players = marks.map{|mark| HumanPlayer.new(mark)}
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
            pos = @current_player.get_position
            @board.place_mark(pos, @current_player.mark)
            if @board.win?(@current_player.mark)
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
