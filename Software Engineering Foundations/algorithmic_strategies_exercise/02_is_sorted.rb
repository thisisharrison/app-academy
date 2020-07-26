# Write a method, is_sorted(arr), that accepts an array of numbers as an arg.
# The method should return true if the elements are in increasing order, false otherwise.
# Do not use the built-in Array#sort in your solution :)

def is_sorted(arr)

    (0...arr.length-1).all? { |i| arr[i] <= arr[i+1] } # returns true if block never returns false or nil

    # sorted = false
    # while !sorted
    #     sorted = true
    #     (0...arr.length-1).each do |i|
    #         # puts i
    #         if arr[i] > arr[i+1]
    #             return false
    #         end
    #     end
    # end
    
    # sorted
        
end

p is_sorted([1, 4, 10, 13, 15])       # => true
p is_sorted([1, 4, 10, 10, 13, 15])   # => true
p is_sorted([1, 2, 5, 3, 4 ])         # => false
