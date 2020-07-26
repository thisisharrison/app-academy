class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
  def self.random_word # class method, not instance method. Better choice as code inside the method does not pertain to certain instance of Hangman = it does not refer instances of @instance variables
    DICTIONARY.sample
  end
  
  def initialize
    @secret_word = Hangman.random_word # class method, call it on the Class => Hangman#
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    return true if @attempted_chars.include?(char)
    return false if !@attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    secret = @secret_word.split("")
    indices = []

    @secret_word.each_char.with_index do |char_1, i|
      indices << i if char_1 == char
    end

    # secret.each_with_index do | char_1, i |
    #   if char_1 == char
    #     indices << i
    #   end
    # end
    indices
  end

  def fill_indices(char, array)
    array.each { |i| @guess_word[i] = char }
  end

  def try_guess(char)
    if self.already_attempted?(char)
      p 'that has already been attempted'
      return false
    end

    @attempted_chars << char
    indices = get_matching_indices(char)

    if indices.empty?
      @remaining_incorrect_guesses -= 1
    else
      self.fill_indices(char, indices)
    end

    return true
  end

  def ask_user_for_guess
    p 'Enter a char:'
    input = gets.chomp
    return self.try_guess(input)
  end

  def win?
    if @guess_word.join("") == @secret_word
      p 'WIN'
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p 'LOSE'
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      p @secret_word
      return true
    else
      return false
    end
  end

end