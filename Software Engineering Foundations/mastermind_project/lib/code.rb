class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader :pegs

  def self.valid_pegs?(array)
    array.all? {|char| POSSIBLE_PEGS.has_key?(char.upcase)} 
  end

  def initialize(array)
    raise "incorrect pegs" if !Code.valid_pegs?(array)
    @pegs = array.map(&:upcase)
  end  

  def self.from_string(string)
    Code.new(string.split(""))
  end

  def self.random(length)
    Code.new(Array.new(length){POSSIBLE_PEGS.keys.sample}) # sample = random function for arrays 
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    (0...guess.length).count {|i| guess[i] == self[i]} # self[i] = self.pegs[i] = @pegs[i]
  end

  def num_near_matches(guess)
    (0...guess.length).count {|i| self.pegs.include?(guess[i]) && guess[i] != self[i]}
  end

  def ==(guess)
    return false if guess.length != self.length
    # self.num_exact_matches(guess) == self.length
    self.pegs == guess.pegs
  end

end

