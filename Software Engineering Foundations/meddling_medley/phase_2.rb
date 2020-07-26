# Phase 2: More difficult, maybe?

def conjunct_select(arr, *prcs)
    arr.select do |ele|
        prcs.all? do |prc|
            prc.call(ele)
        end
    end
end
# Write a method conjunct_select that accepts an array and one or more procs as arguments. The method should return a new array containing the elements that return true when passed into all of the given procs.

# Examples

# is_positive = Proc.new { |n| n > 0 }
# is_odd = Proc.new { |n| n.odd? }
# less_than_ten = Proc.new { |n| n < 10 }

# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def convert_word(word)
    vowels = "aeiou".split("")
    return word if word.length < 3
    return word + "yay" if vowels.include?(word[0].downcase)
    

    new_word = ""
    (0...word.length).each do |i|
        if vowels.include?(word[i].downcase)
            new_word += word[i..-1] + word[0...i] + "ay" 
            return word.capitalize == word ? new_word.capitalize : new_word.downcase
        end
    end
end

def convert_pig_latin(str)
    words = str.split(" ")
    new_str = words.map{|word| convert_word(word)}.join(" ")
end
# Write a method convert_pig_latin that accepts a sentence as an argument. The method should translate the sentence according to the following rules:

# words that are shorter than 3 characters are unchanged
# words that are 3 characters or longer are translated according to the following rules:
# if the word begins with a vowel, simply add 'yay' to the end of the word (example: 'eat'->'eatyay')
# if the word begins with a non-vowel, move all letters that come before the word's first vowel to the end of the word and add 'ay' (example: 'trash'->'ashtray')
# Note that if words are capitalized in the original sentence, they should remain capitalized in the translated sentence. Vowels are the letters a, e, i, o, u.

# Examples

# p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
# p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
# p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
# p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
# p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def revert_word(word)
    vowels = 'aeiouAEIOU'.split("")
    return word + word if vowels.include?(word[-1])
    
    i = word.length - 1
    while i >= 0
        if vowels.include?(word[i])
            return word + word[i..-1]
        end
        i -= 1
    end
end

def reverberate(str)
    words = str.split(" ")
    new_str = words.map do |word| 
        new_word = word.length > 2 ? revert_word(word) : word
        new_word = word.capitalize == word ? new_word.capitalize : new_word
    end
    new_str.join(" ")
end
# Write a method reverberate that accepts a sentence as an argument. The method should translate the sentence according to the following rules:

# words that are shorter than 3 characters are unchanged
# words that are 3 characters or longer are translated according to the following rules:
# if the word ends with a vowel, simply repeat the word twice (example: 'like'->'likelike')
# if the word ends with a non-vowel, repeat all letters that come after the word's last vowel, including the last vowel itself (example: 'trash'->'trashash')
# Note that if words are capitalized in the original sentence, they should remain capitalized in the translated sentence. Vowels are the letters a, e, i, o, u.

# Examples

# p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
# p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
# p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
# p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *prcs)
    arr.select do |ele|
        prcs.any? {|prc| prc.call(ele)}
    end
end
# Write a method disjunct_select that accepts an array and one or more procs as arguments. The method should return a new array containing the elements that return true when passed into at least one of the given procs.

# Examples

# longer_four = Proc.new { |s| s.length > 4 }
# contains_o = Proc.new { |s| s.include?('o') }
# starts_a = Proc.new { |s| s[0] == 'a' }

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
# ) # ["apple", "teeming"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o
# ) # ["dog", "apple", "teeming", "boot"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o,
#     starts_a
# ) # ["ace", "dog", "apple", "teeming", "boot"]

def remove_vowel(word)
    vowels = 'aeiouAEIOU'.split("")
    (0...word.length).each {|i| return word[0...i] + word[i+1..-1] if vowels.include?(word[i])}
    word
end

def remove_last_vowel(word)
    remove_vowel(word.reverse).reverse
end

def alternating_vowel(str)
    new_str = str.split(" ").map.with_index do |word, i| 
        i.even? ? remove_vowel(word) : remove_last_vowel(word)
    end
    new_str.join(" ")
end
# Write a method alternating_vowel that accepts a sentence as an argument. The method should return a new sentence where the words alternate between having their first or last vowel removed. For example:

# the 1st word should be missing its first vowel
# the 2nd word should be missing its last vowel
# the 3rd word should be missing its first vowel
# the 4th word should be missing its last vowel
# ... and so on
# Note that words that contain no vowels should remain unchanged. Vowels are the letters a, e, i, o, u.

# Examples

# p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
# p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
# p alternating_vowel('code properly please') # "cde proprly plase"
# p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def sillify(word)
    vowels = 'aeiouAEIOU'.split("")
    return word + word[-1] if vowels.include?(word[-1])
    new_word = ""
    word.each_char do |char|
        if vowels.include?(char) 
            new_word += char + 'b' + char 
        else
            new_word += char
        end
    end
    word.capitalize == word ? new_word.capitalize : new_word
end

def silly_talk(str)
    str.split(" ").map{|word| sillify(word)}.join(" ")
end
# Write a method silly_talk that accepts a sentence as an argument. The method should translate each word of the sentence according to the following rules:

# if the word ends with a vowel, simply repeat that vowel at the end of the word (example: 'code'->'codee')
# if the word ends with a non-vowel, every vowel of the word should be followed by 'b' and that same vowel (example: 'siren'->'sibireben')
# Note that if words are capitalized in the original sentence, they should remain capitalized in the translated sentence. Vowels are the letters a, e, i, o, u.

# Examples

# p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
# p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
# p silly_talk('They can code') # "Thebey caban codee"
# p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

def compress(str)
    count = 1
    new_str = ""
    (1..str.length).each do |i|
        if str[i - 1] == str[i] # last char [i-1] == str[i] (length = nil), equals false
            count += 1 
        else
            if count > 1
                new_str += str[i-1] + count.to_s 
            else 
                new_str += str[i-1] # edge case adding last char
            end
            count = 1
        end
    end
    new_str
end
# Write a method compress that accepts a string as an argument. The method should return a "compressed" version of the string where streaks of consecutive letters are translated to a single appearance of the letter followed by the number of times it appears in the streak. If a letter does not form a streak (meaning that it appears alone), then do not add a number after it.

# Examples

# p compress('aabbbbc')   # "a2b4c"
# p compress('boot')      # "bo2t"
# p compress('xxxyxxzzzz')# "x3yx2z4"