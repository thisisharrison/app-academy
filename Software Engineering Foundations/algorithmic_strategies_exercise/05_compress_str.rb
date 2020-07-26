# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
    string = ""
    i = 0
    
    while i < str.length
        counter = 0
        char = str[i] # take first char and see how far it'll match

        while char == str[i] # see how far it'll match
            counter += 1
            i += 1
        end

        if counter > 1
            string += counter.to_s + char # append count of char to char
        else
            string += char # if no matches, just append char
        end

        # i += 1 # move to next char $ no need as i is now @ last matched char
    end

    string

end

p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
