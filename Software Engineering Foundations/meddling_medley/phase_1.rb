# Phase 1: Modest problems.

def duos(str)
    count = 0
    (1...str.length).each do |i|
        count += 1 if str[i] == str[i-1]
    end
    count
end
# Write a method duos that accepts a string as an argument and returns the count of the number of times the same character appears consecutively in the given string.

# Examples
# p duos('bootcamp')      # 1
# p duos('wxxyzz')        # 2
# p duos('hoooraay')      # 3
# p duos('dinosaurs')     # 0
# p duos('e')             # 0

def sentence_swap(str, hash)
    words = str.split(" ")
    new_words = words.map do |word|
        if hash.has_key?(word)
            hash[word] 
        else
            word
        end
    end
    new_words.join(" ")
end
# Write a method sentence_swap that accepts a sentence and a hash as arguments. The method should return a new sentence where every word is replaced with it's corresponding value in the hash. If a word does not exist as a key of the hash, then it should remain unchanged.

# Examples

# p sentence_swap('anything you can do I can do',
#     'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
# ) # 'nothing you shall drink I shall drink'

# p sentence_swap('what a sad ad',
#     'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
# ) # 'make a happy ad'

# p sentence_swap('keep coding okay',
#     'coding'=>'running', 'kay'=>'pen'
# ) # 'keep running okay'

def hash_mapped(hash, v_prc, &k_prc)
    new_hash = {}
    hash.each do |k,v|
        new_hash[k_prc.call(k)] = v_prc.call(v)
    end
    new_hash
end
# Write a method hash_mapped that accepts a hash, a proc, and a block. The method should return a new hash where each key is the result of the original key when given to the block. Each value of the new hash should be the result of the original values when passed into the proc.

# Examples

# double = Proc.new { |n| n * 2 }
# p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# # {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

# first = Proc.new { |a| a[0] }
# p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# # {25=>"q", 36=>"w"}

def counted_characters(str)
    count = Hash.new(0)
    str.each_char do |char|
        count[char] += 1
    end
    count.select {|k, v| v > 2}.keys
    
    # result = []
    # count.each do |k, v| 
    #     result << k if v > 2
    # end
    # result
end
# Write a method counted_characters that accepts a string as an argument. The method should return an array containing the characters of the string that appeared more than twice. The characters in the output array should appear in the same order they occur in the input string.

# Examples

# p counted_characters("that's alright folks") # ["t"]
# p counted_characters("mississippi") # ["i", "s"]
# p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
# p counted_characters("runtime") # []

# use slicing
def triplet_true?(str)
    (0...str.length-2).each do |i|
        if str[i..i+2] == str[i] * 3
            return true
        end
    end
    false
end
# def triplet_true?(str)
#     (1...str.length).each do |i|
#         if str[i] == str [i-1] && str[i-1] == str [i-2]
#             return true
#         end
#     end
#     false
# end

# Write a method triplet_true? that accepts a string as an argument and returns a boolean indicating whether or not the string contains three of the same character consecutively.

# Examples

# p triplet_true?('caaabb')        # true
# p triplet_true?('terrrrrible')   # true
# p triplet_true?('runninggg')     # true
# p triplet_true?('bootcamp')      # false
# p triplet_true?('e')             # false

def energetic_encoding(str, hash)
    alpha = ("a".."z").to_a
    new_str = ""
    str.each_char do |char|
        if hash.has_key?(char) && alpha.include?(char)
            new_str += hash[char]
        elsif alpha.include?(char)
            new_str += "?"
        else
            new_str += char
        end
    end
    new_str
end
# Write a method energetic_encoding that accepts a string and a hash as arguments. The method should return a new string where characters of the original string are replaced with the corresponding values in the hash. If a character is not a key of the hash, then it should be replaced with a question mark ('?'). Space characters (' ') should remain unchanged.

# Examples

# p energetic_encoding('sent sea',
#     'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
# ) # 'zimp ziu'

# p energetic_encoding('cat',
#     'a'=>'o', 'c'=>'k'
# ) # 'ko?'

# p energetic_encoding('hello world',
#     'o'=>'i', 'l'=>'r', 'e'=>'a'
# ) # '?arri ?i?r?'

# p energetic_encoding('bike', {}) # '????'

def uncompress(str)
    new_str = ""
    (0...str.length).each do |i|
        if i % 2 != 0
            new_str += str[i-1] * str[i].to_i
        end
    end
    new_str
end
# Write a method uncompress that accepts a string as an argument. The string will be formatted so every letter is followed by a number. The method should return an "uncompressed" version of the string where every letter is repeated multiple times given based on the number that appears directly after the letter.

# Examples

# p uncompress('a2b4c1') # 'aabbbbc'
# p uncompress('b1o2t1') # 'boot'
# p uncompress('x3y1x2z4') # 'xxxyxxzzzz'