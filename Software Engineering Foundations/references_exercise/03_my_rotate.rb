# Write a method, my_rotate!(array, amt), that accepts an array and a number as args.
# The method should mutate the array by rotating the elements 'amt' number of times. 
# When given a positive 'amt', a single rotation will rotate left, causing the first element to move to the last index
# When given a negative 'amt', a single rotation will rotate right, causing the last element to move to the first index
# The method should return the given array.
# Do not use the built-in Array#rotate
# 
# Note: this method must MUTATE the input array. This means that the object_id of the input array should be identical
# to the object_id of the returned array. The exact object_ids you get back don't matter. We just want the ids
# to be the same before and after calling your method.


def my_rotate!(array, amt)

    if amt > 0
        # shift left 
        amt.times do 
            ele = array.shift # take out first ele
            array << ele # shuffle to the end
        end
    else
        # shift right 
        (-amt).times do # make number positive again # brackets are essential
            ele = array.pop # take out last ele
            array.unshift(ele) # add to beginning
        end
    end
    array
    









    # i = 0
    # if amt > 0
    #     while i < amt
    #         (0...array.length-1).each do |i|
    #             array[i], array[i+1] = array[i+1],array[i]
    #         end
    #         i += 1
    #     end
    # else 
    #     while i > amt
    #         right = array[i+1]
    #         mid = array[i]

    #         temp = array[0]
    #         array[0] = array[-1]
    #         array[1] = temp
            
    #         temp = array[i]
    #         array[i+1] = array[i]

    #         end
    #         i -= 1
    #     end
    # end
    # array
end


array_1 = ["a", "b", "c", "d"]
p array_1.object_id                 # => 70354216023780
result_1 = my_rotate!(array_1, 2)
p result_1                          # => ["c", "d", "a", "b"]
p result_1.object_id                # => 70354216023780


array_2 = ["NOMAD", "SOHO", "TRIBECA"]
p array_2.object_id                 # => 70354216019660
result_2 = my_rotate!(array_2, 1)
p result_2                          # => ["SOHO", "TRIBECA", "NOMAD"]
p result_2.object_id                # => 70354216019660


array_3 = ["a", "b", "c", "d"]
p array_3.object_id                 # => 70354216016500
result_3 = my_rotate!(array_3, -3)
p result_3                          # => ["b", "c", "d", "a"]
p result_3.object_id                # => 70354216016500
