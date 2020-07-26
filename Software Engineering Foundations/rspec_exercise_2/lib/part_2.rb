def palindrome?(word)
    word.each_char.with_index { |char, i|
        if word[i] != word[-i -1] 
            return false
        end
    }
    true
end

def substrings(word)
    sub = []
    (0...word.length).each do |start|
        (start...word.length).each do |last| 
            sub << word[start..last]
        end
    end
    sub
end


def palindrome_substrings(string)
    substrings(string).select {|sub| sub.length > 1 && palindrome?(sub)}
end



# if word[i] != word[-i -1] # gives us 0 == -1, 1 == -2, 2 == -3
# (start...word.length).each do |last| # exclude overflow length with '...'

    # new_str = ""
    # i = word.length - 1
    # while i >= 0
    #     new_str += word[i]
    #     i -= 1
    # end
    # word == new_str