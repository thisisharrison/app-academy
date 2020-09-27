#Problem 1: 

def sum_recur(array)
    return array[0] if array.count == 1
    array[0] + sum_recur(array[1..-1])
end

# p sum_recur([1,2,3,4,5])

#Problem 2: 

def includes?(array, target)
    return true if array.first == target
    return false if array.empty?
    includes?(array.drop(1), target)
end

# Array#drop instead of shift to preserve original array

# p includes?([1,2,3],2)

# Problem 3: 

def num_occur(array, target)
    return 0 if array.empty?
    count = array.first == target ? 1 : 0
    count + num_occur(array.drop(1), target)
end

# p num_occur([1,2,1,3,1],1)
# p num_occur(["h", "a", "r", "r", "i", "s", "o", "n"],'r')

# Problem 4: 

def add_to_twelve?(array)
    return false if array.empty?
    return true if array.take(2).sum == 12
    add_to_twelve?(array.drop(1))
end

# p add_to_twelve?([1,2,4,5,6,6,7,8])

# Problem 5: 

def sorted?(array)
    return true if array.length == 1
    if (array[0] <=> array[1]) == 1
        return false
    else
        sorted?(array[1..-1])
    end
end

# p sorted?([5, 1, 10, 4, 8])
# p sorted?([1, 2, 3, 4, 5])

# Problem 6: 

def reverse(string)
    return string if string.length == 1
    string[-1] + reverse(string[0...-1])
end

# p reverse('Hello')
