class HumanPlayer
    
    attr_accessor :previous_guess
    
    def initialize(name)
        @previous_guess = nil
    end

    def get_input 
        self.prompt
        pos = gets.chomp
        pos.split(" ").map(&:to_i)
    end

    def prompt
        puts "Enter a position (eg. '0 0'): \n"
    end

    def invalid_guess
        puts "Invalid guess"
    end

    def receive_match(pos_1, pos_2)
        puts "It's a match!"
    end

    def receive_revealed_card(pos, value)
        # do nothing
    end
end