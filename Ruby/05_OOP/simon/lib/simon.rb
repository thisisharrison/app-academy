class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize(sequence_length = 1)
    @sequence_length = sequence_length
    @game_over = false
    @seq = []
  end

  def play
    until @game_over 
      take_turn
      system("clear")
    end

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence

    unless @game_over
      round_success_message
      @sequence_length += 1
    end
    
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      puts color 
      sleep(0.5)
      system("clear")
      sleep(0.5)
    end
  end

  def require_sequence
    puts "your turn. first letter of color in each line"
    
    @seq.each do |color|
      user = gets.chomp.downcase
      if color[0] != user
        @game_over = true
        break
      end
    end
    sleep(0.5)
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    "level up"
  end

  def game_over_message
    puts "game over. you made it #{@sequence_length - 1} rounds"
  end

  def reset_game
    @seq = []
    @sequence_length = 1
    @game_over = false
  end
end

if __FILE__ == $PROGRAM_NAME
  s = Simon.new
  s.play
end