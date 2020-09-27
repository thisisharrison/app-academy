class TowersOfHanoiGame
    attr_accessor :towers
    def initialize
        @towers = [[3,2,1], [], []]
    end

    def render
        display = ""
        towers.each_with_index do |tower, i| 
            display += "Tower #{i}: #{tower.join(' ')}\n"
        end
        display
    end

    def move(start_pos, end_pos)
        raise "stack is empty" if @towers[start_pos].empty?
        raise "moving onto a smaller disk" unless valid_move(start_pos, end_pos)
        disc = @towers[start_pos].pop
        @towers[end_pos] << disc
    end

    def valid_move(start_pos, end_pos)
        return false unless [start_pos, end_pos].all? { |i| i.between?(0, 2) }
        
        !@towers[start_pos].empty? && (@towers[end_pos].empty? || @towers[start_pos].last < @towers[end_pos].last)
        
    end

    def won?
        @towers[0].empty? && @towers[1..2].any? { |tower| tower == [3,2,1] }
    end

    def play
        while !won?
            begin
                puts self.render
                puts "From which tower?"
                start_pos = gets.chomp.to_i
                puts "To which tower?"
                end_pos = gets.chomp.to_i
                self.move(start_pos, end_pos)
            rescue => e
                puts e.message
                sleep(1)
                system("clear")
                retry    
            end
            system("clear")
        end
        "Game over!"
    end
end

if __FILE__ == $PROGRAM_NAME
    g = TowersOfHanoiGame.new
    g.play
end