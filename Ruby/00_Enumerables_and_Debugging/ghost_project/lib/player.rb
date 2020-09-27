class Player

    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess
        print "Add a letter: "
        gets.chomp.downcase
    end

    def alert_invalid_guess
        print "Invalid guess\n"
    end
end

