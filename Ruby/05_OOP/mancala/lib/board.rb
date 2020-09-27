class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, i|
      # next for the store cups
      next if i == 6 || i == 13
      4.times do 
        cup << :stone
      end
    end
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' if !start_pos.between?(0, 13)
    raise 'Starting cup is empty' if @cups[start_pos].length == 0
  end

  def make_move(start_pos, current_player_name)
    # empties the cup
    stones = @cups[start_pos]
    @cups[start_pos] = []
    
    idx = start_pos
    # distribute stones 
    until stones.empty?
      idx += 1
      # wrap around if greater than 13
      idx = 0 if idx > 13
      # add stones only to your own cups
      if idx == 6
        @cups[6] << stones.pop if current_player_name == @name1
      elsif idx == 13
        @cups[13] << stones.pop if current_player_name == @name2
      else
        # otherwise every cup can add stones 
        @cups[idx] << stones.pop
      end
    end
    render
    next_turn(idx)
  end

  def next_turn(ending_cup_idx)
    # landed on their own cup, turn is not yet over
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    # landed on cup with one stone left 
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (0..5).all? { |i| @cups[i].empty? } || (7..12).all? { |i| @cups[i].empty? }
  end

  def winner
    cup1 = @cups[6].length
    cup2 = @cups[13].length
    return :draw if cup1 == cup2
    return cup1 > cup2 ? @name1 : @name2
  end
end
