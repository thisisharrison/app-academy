# PHASE 2
def convert_to_int(str)
  
  begin
    num = Integer(str)  
  rescue ArgumentError 
    puts "Not a suitable argurment"
  ensure 
    num ||= 0
  end
    num
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class CoffeeError < StandardError
  def message
    "Too much caffeine"
  end
end

class NotaFruit < StandardError
  def message
    "What are you feeding me"
  end
end

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee" 
    raise CoffeeError
  else
    raise NotaFruit
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue CoffeeError => e
    puts e.message
    retry
  rescue NotaFruit => e
    puts e.message
    retry
  end
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new("'yrs_known' is too short") if yrs_known.to_i < 5
    raise ArgumentError.new("'name' can't be blank") if name.length <= 0
    raise ArgumentError.new("'fav_pastime' can't be blank") if fav_pastime.length <= 0

    @name = name
    @fav_pastime = fav_pastime
    @yrs_known = yrs_known.to_i
    
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


