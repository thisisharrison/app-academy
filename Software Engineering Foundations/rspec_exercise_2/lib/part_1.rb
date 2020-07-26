def partition(arr, n)
    result = Array.new(2){Array.new}
    i = 0
    while i < arr.length
        if arr[i] < n
            result[0] << arr[i]
        else
            result[1] << arr[i]
        end
        i += 1
    end 
    result
end

def merge(hash_1, hash_2)
    hash = Hash.new
    hash_1.each { |key, v| 
        hash[key] = v
    }
    hash_2.each { |key, v| 
        hash[key] = v
    }
    hash
end

def censor(str, arr)

    words = str.split(" ")

    new_words = words.map { |word|
        if arr.include?(word.downcase)
            star_word(word)
        else
            word
        end
    }

    new_words.join(" ")

    # vowels = "aeiou"
    # new_arr = str.split(" ")
    # new_arr.each {|word|
    #     if arr.include?(word.downcase)
    #         word.each_char do |char| 
    #             if vowels.include?(char.downcase)
    #                 char = "*"
    #             else
    #                 char
    #             end
    #         end
    #     else
    #         word
    #     end
    # }
end

def star_word(word)

    vowels = "aeiou"
    new_str = ""
    word.each_char {|char| 
        if vowels.include?(char.downcase)
            new_str += "*"
        else
            new_str += char
        end
    }
    return new_str

end

def power_of_two?(number)
    
    product = 1 

    while product < number
        product *= 2
    end

    product == number
    
end