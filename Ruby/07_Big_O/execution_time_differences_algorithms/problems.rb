list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

# Phase I
# O(n^2) quadratic time
# O(n^2) quadratic space: it uses list
def phase_Ib_my_min(list)
    smallest = nil
    list.each do |el|
        list_dup = list.dup
        list_dup.delete(el)
        smallest = el if list_dup.all? { |i| i > el }
    end
    smallest
end

# puts phase_I_my_min(list)  # =>  -5

# Phase II
# O(n^2) quadratic time
# O(1) constant space: it uses e1 and e2
def phase_II_my_min(list)
    list.each_with_index do |e1, i1|
        smallest = true
        list.each_with_index do |e2, i2|
            next if i1 == i2
            smallest = false if e2 < e1
        end
        return e1 if smallest
    end
end

# puts phase_II_my_min(list)  # =>  -5

# Phase I
# O(n^3) cubic time
# O(n^3) cubic space
def nested_subsum(list)
    all_sub = []
    list.each_index do |i1|
        (i1..list.length - 1).each do |i2|
            all_sub << list[i1..i2]
        end
    end
    all_sub.map { |sub| sub.inject(:+) }.max
end

# Phase II
# O(n) linear time
# O(1) constant space
def quicker_subsum(list)
    largest = list.first 
    curr_largest = list.first 
    (1...list.length).each do |i|
        # to handle -ve numbers += -ve only becomes smaller 
        curr_largest = 0 if curr_largest < 0
        curr_largest += list[i]
        largest = curr_largest if curr_largest > largest
    end
    largest
end


list = [2, 3, -6, 7, -6, 7]
# puts nested_subsum(list)
# puts quicker_subsum(list) # => 8 

list = [-5, -1, -3]
# puts nested_subsum(list)
# puts quicker_subsum(list) # => -1
