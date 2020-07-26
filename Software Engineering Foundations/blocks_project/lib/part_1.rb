def select_even_nums(array)
    array.select(&:even?)
end

def reject_puppies(array) 
    array.reject { |dog| dog["age"] <= 2 }
end

def count_positive_subarrays(array)
    array.count { |subarray| subarray.sum > 0 }
end 

def aba_translate(string)
    vowels = "aeiou"
    new_str = ""
    string.each_char {|ele| 
        if vowels.include?(ele)
            new_str += ele + 'b' + ele
        else
            new_str += ele
        end
    }
    return new_str
end

def aba_array(array)
    array.map {|word| aba_translate(word)}
end
