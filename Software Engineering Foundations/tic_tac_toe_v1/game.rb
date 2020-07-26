require './board.rb'
require './human_player.rb'

class Game
    def initialize(player_1_mark, player_2_mark)
        @player_1 = HumanPlayer.new(player_1_mark)
        @player_2 = HumanPlayer.new(player_2_mark)
        @current_player = @player_1
        @board = Board.new 
    end

    def switch_turn
        if @current_player == @player_1  
            @current_player = @player_2
        else
            @current_player = @player_1
        end
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
