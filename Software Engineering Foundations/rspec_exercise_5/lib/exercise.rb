def zip(*arrays)
    length = arrays.first.length

    (0...length).map do |i| # map using index and create an outer array with map
        arrays.map {|array| array[i]} # returns sub array of ele in i index
    end
end

def prizz_proc(array, prc_1, prc_2)
    array.select {|ele|
        ele if !prc_1.call(ele) && prc_2.call(ele) || prc_1.call(ele) && !prc_2.call(ele) 
    }
end

def zany_zip(*arrays)
    length = arrays.map(&:length).max
    
    # length = 0
    # arrays.each {|array| length = array.length if array.length > length}
    
    (0...length).map do |i|
        arrays.map do |array| 
            array[i]
        end
    end
end

array_1 = ['a', 'b', 'c']
array_2 = [1, 2, 3]
array_3 = [11, 13, 15, 17]
array_4 = ['v', 'w', 'x', 'y', 'z']
    
# p zany_zip(array_1) 
# p zany_zip(array_1, array_2) 
# p zany_zip(array_1, array_2, array_3) 



def maximum(array, &prc)
    return nil if array.empty?
    max = array.first

    array.each do |ele|
        max = ele if prc.call(ele) >= prc.call(max)
    end
    
    max 
end

maximum([2, 4, -5, 1]) { |n| n * n } # -5


def my_group_by(array, &prc)
    result = Hash.new {|h, k| h[k] = []}
    array.each do |ele|
        key = prc.call(ele)
        result[key] << ele
    end
    result
end

def max_tie_breaker(array, tie_break, &prc_1)
    return nil if array.empty?
    max = array.first 
    array.each do |ele|
        if prc_1.call(ele) > prc_1.call(max)
            max = ele
        elsif prc_1.call(ele) == prc_1.call(max) && tie_break.call(ele) > tie_break.call(max) # if second argument false, returned ele that comes first in the array = the previous max
            max = ele
        end
    end
    max
end

def vowel_idx(word)
    vowels = 'aeiou'
    v_idx = []
    word.each_char.with_index do |char, i|
        v_idx << i if vowels.include?(char)
    end
    v_idx
end

def silly_syllables(str)
    words = str.split(" ")

    new_words = words.map do |word|
        v_idx = vowel_idx(word)
        if v_idx.length < 2
            word
        else
            first_i = v_idx.first
            last_i = v_idx.last 
            word = word[first_i..last_i]
        end
    end
    new_words.join(" ")
end

