# GENERAL PROBLEMS #

def no_dupes?(array)
    count = Hash.new(0)
    array.each {|ele| count[ele] += 1}
    count.keys.select {|ele| count[ele] == 1}
    # result = []
    # count.each do |k,v| 
    #     result << k if v == 1
    # end
    # result
end

# Examples
# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    (0...arr.length-1).each do |idx|
        return false if arr[idx] == arr[idx + 1]
    end
    true
end

# Examples
# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    count = Hash.new {|h, k| h[k] = []} # each new hash do this proc h[k] = []
    str.each_char.with_index {|char,i| count[char] << i}
    count
end

# Examples
# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    current = ""
    best = ""

    (0...str.length).each do |i|
        if str[i] == str[i-1] || str[i] == 0 # i == i - 1: measures if you're on a streak, but set clause for i = 0
            current += str[i]
        else
            current = str[i]
        end
        best = current if current.length >= best.length # replace best with most recent streak that ties with best
    end

    best
end

# Examples
# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

def bi_prime?(num)
    prime_factors = prime_factor(num)
    prime_factors.any? do |i|
        x = num / i
        prime_factors.include?(x) # proves i and x are both in prime_factors and multiply them equals num
    end
    # (2...num).each do |f_1|
    #     (2...num).each do |f_2|
    #         return true if f_1 * f_2 == num && is_prime?(f_1) && is_prime?(f_2)
    #     end
    # end
    # false
end

def is_prime?(num)
    return false if num < 2
    (2...num).none? {|factor| num % factor == 0} # if any return true, this will be false
    # (2...num).each do |factor|
    #     return false if num % factor == 0
    # end
    # true
end

def prime_factor(num)
    (2..num).select {|n| is_prime?(n) && num % n == 0}
end

# Examples
# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

def vigenere_cipher(message, keys)
    alpha = ('a'..'z').to_a
    new_str = ""

    message.each_char.with_index do |char, idx|
        
        k = idx % keys.length # keys need to wrap around 
        i = (alpha.index(char) + keys[k]) % alpha.length
        new_char = alpha[i]

        new_str += new_char
    end

    return new_str
end

# Examples
# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    new_str = str[0..-1] # makes copy of old str
    vowels = 'aeiou'
    v_idx = (0...str.length).select {|i| vowels.include?(str[i])}
    new_v_idx = v_idx.rotate(-1) # [1, 4, 6] --> [6, 1, 4]
    
    v_idx.each_with_index do |ele, i| # ele = vowel idex of original str, i = index of this v_idx array
        rot_i = new_v_idx[i] # rotated index in order
        new_str[ele] = str[rot_i]
    end

    new_str
end

# def vowel_rotate(str)
#     vowels = 'aeiou'.split("")
#     array = [] 
#     str.each_char {|char| array << char if vowels.include?(char)}

#     new_str = ""

#     str.each_char do |char|
#         if !array.include?(char)
#             new_str += char
#         elsif !vowels.any? {|c| new_str.include?(c)}
#             new_str += array[-1]
#         else
#             new_str += array.shift
#         end
#     end

#     new_str
# end

# Examples
# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"



# Proc Problems #

class String

    def select(&prc)
        return "" if prc.nil?
        new_str = ""

        self.each_char do |char|
            new_str += char if prc.call(char) # return character of the string that returns true to this proc
        end

        new_str
    end

    def map!(&prc)
        self.each_char.with_index do |ch, i| # each_char dot with_index => chaining two methods together
            self[i] = prc.call(ch, i) # proc can take in char and idex 
        end
        self
    end
end


# Examples (String#select)
"app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
"HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
"HELLOworld".select          # => ""

# Examples (String#map!)
word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
# p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
# p word_2        # => "DiJkStRa"



# Recursion Problems #

def multiply(a, b)
    return 0 if b == 0 
    if b < 0 
        -(a + multiply(a, (-b) - 1))
    else
        a + multiply(a, b - 1)
    end
end

# make b positive and -1, if b is negative then result is negative. if a is negative and outer bracket is negative, then get a postive 

# Examples
# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18


def lucas_sequence(num)

    return [] if num == 0 
    return [2] if num == 1
    return [2, 1] if num == 2
    
    seq = lucas_sequence(num - 1) 
    seq << seq[-2..-1].sum
    seq
end
# eg. 3 - 1 = lucas_sequence(2) = [2, 1]. Then shuffle [-2..-1].sum = 3

# Examples
# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]    
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

def prime_factorization(num)
    (2...num).each do |factor|
        if num % factor == 0
            other_factor = num / factor
            p factor 
            p other_factor
            p '---'
            return  [ *prime_factorization(factor), *prime_factorization(other_factor) ]
        end
    end
    [num] # return self if above condition not met (i.e. no factors)
end

# Examples
# p prime_factorization(12)     # => [2, 2, 3]
# p prime_factorization(24)     # => [2, 2, 2, 3]
# p prime_factorization(25)     # => [5, 5]
# p prime_factorization(60)     # => [2, 2, 3, 5]
# p prime_factorization(7)      # => [7]
# p prime_factorization(11)     # => [11]
# p prime_factorization(2017)   # => [2017]



# splat unpacks an array, like remove the brackets ([]) that enclose the array. 
# Eg. 
# arr_1 = ["a", "b"]
# arr_2 = ["d", "e"]
# arr_3 = [ *arr_1, "c", *arr_2 ]
# p arr_3 # => ["a", "b", "c", "d", "e"]
