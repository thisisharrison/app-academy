# Brute Force
# O(n^2) quadratic time
# O(n^2) quadratic space
def bad_two_sum?(arr, target_sum)
    arr.each_with_index do |e1, i1|
        arr.each_with_index do |e2, i2|
            next if i1 == i2
            return true if e1 + e2 == target_sum
        end
    end
    false
end

# Sorted
# O(n log n) time - sorting 
# O(n) space
def okay_two_sum?(arr, target_sum)
    arr = arr.sort
    i, j = 0, arr.length-1

    while i < j
        # smallest add largest
        case (arr[i] + arr[j]) <=> target_sum
        when 0
            return true
        # too big, upperbound lower 
        when 1
            j -= 1
        # too small, lowerbound upper
        when -1
            i += 1
        end
    end
    false
end

# Hash map
# O(n) - linear time 
# O(n) - linear space
def hash_two_sum?(arr, target_sum)
    sums = Hash.new
    (0...arr.length-1).each do |i|
        ans = arr[i] + arr[i+1]
        sums[ans] = true
    end
    sums.has_key?(target_sum)
end

def hash_two_sum_v2?(arr, target_sum)
    compliment = Hash.new
    arr.each do |num|
        # num + (target_sum - num) = target_sum 
        # if target_sum - num exists, then two sum exists 
        return true if compliment[target_sum - num]
        compliment[num] = true
    end
    false
end

arr = [0, 1, 5, 7]
# puts hash_two_sum_v2?(arr, 6) # => should be true
# puts hash_two_sum_v2?(arr, 10) # => should be false

def four_sum?(arr, target_sum)
    # hold nums that we have checked
    # hold two sum that we have checked
    # hold three sum that we have checked
    # if next num plus one of three sum equals target_sum, return true

    hash = Hash.new
    two_sum = Hash.new
    three_sum = Hash.new

    arr.each do |num|
        
        # target_sum - num, we got a three sum that is num away from target_sum
        return true if three_sum[target_sum - num]
        
        # add this num to three sums
        two_sum.each_key do |key| 
            three_sum[key + num] = true
        end

        # add this num to two sums 
        hash.each_key do |key|
            two_sum[key + num] = true
        end

        hash[num] = true
    end
    
    false

end

arr = [4, 9, 5, 0, 4, 5]
puts four_sum?(arr, 14)
puts four_sum?(arr, 30)