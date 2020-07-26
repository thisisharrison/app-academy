def average(num1, num2)
    (num1 + num2) / 2.0
end

def average_array(nums)
    nums.sum / (nums.length*1.0) # nums.sum returns sum of the array elements
end

def repeat(str,num)
    str * num

    # new_str = ""
    # num.times do new_str += str end
    # new_str
end 

def yell(string)
    string.upcase + "!" # .upcase will change all chars

    # new_str = ""
    # string.each_char { |char| new_str += char.upcase }
    # new_str+"!"
end

def alternating_case(string)
    arr = string.split(" ")

    new_arr = arr.map.with_index { |char, i| 
        if i%2 == 0
            char.upcase
        else
            char.downcase
        end
    }

    new_arr.join(" ")

    # arr = string.split(" ")
    # (0..arr.length-1).each do |i|
    #     if i%2 == 0
    #         arr[i] = arr[i].upcase
    #     else
    #         arr[i] = arr[i].downcase
    #     end
    # end
    # arr.join(" ")

    # arr = string.split(" ")
    # new = []
    # arr.each.with_index do |word, i| 
    #     if i%2 == 0
    #         new << word.upcase
    #     else
    #         new << word.downcase
    #     end
    # end
    # new.join(" ")
end