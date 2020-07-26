# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]
def all_vowel_pairs(words)

    vowels = 'aeiou'.split("")

    combined = []

    words.each_with_index do |word_1, idx_1|
        words.each_with_index do |word_2, idx_2|
            pair = word_1 + " " + word_2
            combined << pair if idx_2 > idx_1 && vowels.all? {|v| pair.include?(v)}
        end
    end

    # (0...words.length).each do |word_1|
    #     (word_1 + 1...words.length).each do |word_2|
    #         combo = words[word_1] + ' ' + words[word_2]
    #         combined << combo if vowels.all? {|v| combo.include?(v)}
    #     end
    # end

    combined

# starts with idx_1 = 0 and first word | second loop, try 2nd word match with 3rd up to nth word
# starts with idx_2 = 1
# all vowels have a return value of true (i.e. all vowels are found)

end


# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
    (2...num).each do |factor|
        return true if num % factor == 0
    end
    return false
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)

    bigrams.select { |bigram| str.include?(bigram) } # eg. 'app academy'.incldue?('em') => true => select 'em'

    # result = []

    # bigrams.each do |pair|
    #     (0...str.length-1).each do |i|
    #         couple = str[i] + str[i+1]
    #         if pair == couple
    #             result << pair
    #         end
    #     end
    # end

    # result

end

class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        prc ||= Proc.new {|k, v| k == v} # turn block, where new hash contain pairs where k is equal to v, into proc and pass to prc as the method; method is nil then call this method 
        # (&prc) => convert above proc to block = my_select {|k, v| k == v} when called without block

        selected = {}
        self.each do |k, v|
            selected[k] = v if prc.call(k, v) # utilize proc, prc.call(k,v), returns true if proc is given
        end
        selected
    end
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    def substrings(length = nil)
        result = []

        (0...self.length).each do |start|
            (start...self.length).each do |ending| # start beginning heading = [0..0] is still [0]
                result << self[start..ending]
            end
        end

        # (0...self.length).each do |start|
        #     result << self[start]
        #     (start+1...self.length). each do |ending|
        #         result << self[start..ending]
        #     end
        # end

        if length.nil?
            result
        else
            result.select {|ele| ele.length == length} # use the result array from all substrings to select ones that meet the length 
        end
            
    end


    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    def caesar_cipher(num)
        alpha = ('a'..'z').to_a # to_a => to array

        new_str = ""

        self.each_char do |char| 
            idx = alpha.index(char)
            new_i = (idx + num) % 26
            new_str += alpha[new_i]
        end

        new_str
    end
end
