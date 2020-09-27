require_relative 'player'

class Game
    ALPHABET = ('a'..'z').to_a
    MAX_LOSSES = 5 # GHOST

    def initialize(*players)
        @players = players.map{ |player| Player.new(player) }
        @fragment = ""
        @dictionary = File.readlines("dictionary.txt").map(&:chomp)
        @losses = Hash.new {|losses, player| losses[player] = 0}
    end

    def current_player
        @players.first
    end

    def previous_player
        @players.last 
    end

    def next_player!
        @players.rotate!
        return self.current_player
    end

    def take_turn
        print "Current fragment is #{@fragment}\n"
        print "It's #{self.current_player.name} turn, add a letter:\n"
        
        letter = current_player.guess
        while !valid_play?(letter)
            self.current_player.alert_invalid_guess
            letter = current_player.guess
        end 
        @fragment += letter
        self.next_player!
    end

    def valid_play?(string)
        return false if string.length != 1 
        return false if !ALPHABET.include?(string)
        potential_frag = @fragment + string
        @dictionary.any?{|word| word.start_with?(potential_frag)}
    end

    def record(player)
        idx = @losses[player]
        'GHOST'.slice(0, idx)
    end

    def display_standings
        @players.each do |player|
            letters = self.record(player)
            print "#{player.name}: " + "#{letters}\n"
        end
    end

    def update_standings
        previous = self.previous_player
        print "#{previous.name} spelled #{@fragment}.\n"
        @losses[previous] += 1 
        points = @losses[previous]
        if points == 5 
            @players.pop(1)
            print "#{previous.name} exited the game\n"
        end
        self.display_standings
    end

    def round_over?
        return self.update_standings if @dictionary.include?(@fragment)
        false
    end

    def play_round 
        @fragment = ""
        while !round_over?
            take_turn
        end
        @fragment = ""
    end

    def game_over?
        @players.length == 1
    end

    def run
        while !self.game_over?
            self.play_round
        end
        print "#{self.previous_player.name} is final winner\n"
    end
end

if $PROGRAM_NAME == __FILE__
  g = Game.new('harry', 'raden', 'chris')
  g.run
end
