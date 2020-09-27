class ComputerPlayer

    attr_accessor :previous_guess, :board_size

    def initialize(size)
        @board_size = size
        @known_cards = {}
        @matched_cards = {}
        @previous_guess = nil
    end

    def receive_revealed_card(pos, value)
        @known_cards[pos] = value
    end

    # when match, remove from known cards
    def receive_match(pos_1, pos_2)
        @matched_cards[pos_1] = true
        @matched_cards[pos_2] = true
        puts "It's a match!"
    end

    def get_input
        if @previous_guess
            second_guess
        else
            first_guess
        end
    end

    def unmatched_pos
        pos, value = @known_cards.find do |p1, v1|
            @known_cards.any? do |p2, v2|
                (p1 != p2 && v1 == v2) && !(@matched_cards[p1] || @matched_cards[p2])
            end
        end
        pos
    end

    def matched_pos
        pos, value = @known_cards.find do |p1, v1|
            p1 != @previous_guess && @known_cards[@previous_guess] == v1 && !@matched_cards[p1]
        end
        pos
    end

    def first_guess
        unmatched_pos || random_guess
    end

    def second_guess
       matched_pos || random_guess
    end

    def random_guess
        guess = nil
        # we make a guess that we have not made before
        until guess && !@known_cards[guess]
            guess = [rand(@board_size), rand(@board_size)]
        end
        guess
    end

    def invalid_guess
        # do nothing
    end 
end
