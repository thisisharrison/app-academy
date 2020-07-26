def reverser(string, &prc)
    prc.call(string.reverse)

    # if using reverse not allowed
    # new_str = ""
    # i = string.length - 1
    # while i >= 0
    #     new_str += string[i]
    #     i -= 1
    # end
    # prc.call(new_str)
end

def word_changer(string, &prc) # & => means it can accept word_changer("example"){|word| word + '!'}
    arr = string.split(" ")

    new_arr = arr.map {|word| prc.call(word)}
    return new_arr.join(" ")

    # if not allowed to use map
    # new_arr = []
    # arr.each do |word|
    #     new_arr << prc.call(word)
    # end
    # return new_arr.join(" ")
end

def greater_proc_value(number, prc_1, prc_2) # no & => means some where we need Proc.new and use it as an argument
    first_result = prc_1.call(number)
    second_result = prc_2.call(number)
    if first_result > second_result 
        first_result 
    else
        second_result
    end
end

def and_selector(array, prc_1, prc_2)
    result = [] 
    array.each do |ele|
        result << ele if prc_1.call(ele) && prc_2.call(ele)
    end
    result
end

def alternating_mapper(array, prc_1, prc_2)
    # 0, 2, 4... indices = first proc
    # 1, 3, 5... indices = secon proc
    result = []
    # using #each_with_index and #even method 
    array.each_with_index do |ele, i|
        if i.even?
            result << prc_1.call(ele)
        else
            result << prc_2.call(ele)
        end
    end

    # l = array.length - 1
    # (0..l).each do |i|
    #     if i % 2 == 0 # index is even, call first proc
    #         result <<  prc_1.call(array[i])
    #     elsif i % 2 != 0 # index is odd, call second proc
    #         result << prc_2.call(array[i])
    #     end
    # end
    result
end
