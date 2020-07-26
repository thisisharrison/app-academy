def hipsterfy(word)

    vowels = "aeiou"

    i = word.length - 1 
    while i >= 0
        if vowels.include?(word[i])
            return word[0...i] + word[i+1..-1] # slicing the word
        end
        i -= 1
    end
    word

    # last = 0
    # (0..word.length-1).each do |i|
    #     if vowels.include?word[i] 
    #         last = i 
    #     end
    # end
    # if last < 1
    #     word 
    # else 
    #     word[last] = ""
    #     word
    # end
end

def vowel_counts(string)
    result = Hash.new(0)
    vowels = 'aeiou'
    string.each_char do |char| 
        if vowels.include?(char.downcase)
            result[char.downcase] += 1 
        end 
    end
    result
end

def caesar_cipher(string, n)
    alphabet = ("a".."z").to_a # gives me an array of a-z
    new_str = ""

    string.each_char do |char|
        
        if alphabet.include?(char)
            old = alphabet.index(char)
            new_i = old + n
            new_str += alphabet[new_i%26]
        else
            new_str += char
        end
    
    end

    new_str

    
    # chars = 'abcdefghijklmnopqurstuvwxyz'
    # string.each_char do |char|
    #     if char.instance_of?(String) && chars.include?(char.downcase) ## prevent space
    #         ele = char.downcase
    #         idx = chars.index(ele)
    #         if ele == char # it's original form is downcase
    #             char = chars[idx+n]
    #         else
    #             char = chars[idx+n].upcase
    #         end
    #     else
    #         ele
    #     end
    # end

        
end

  