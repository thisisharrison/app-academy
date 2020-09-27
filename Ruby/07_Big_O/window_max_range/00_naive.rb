# Max Window Range
# Given an array, and a window size w, find the maximum range (max - min) within a set of w elements.
# 1. [1 2 3] 5
# 2. 1 [2 3 5]
# returns max range (5 - 2 = 3) > (3 - 1 = 2)

# O(n * m) => n: arr, w: window range
def windowed_max_range(arr, w)
    # how many windows can there be 
    num_windows = arr.length - w + 1
    best_max = nil
    num_windows.times do |i|
        window = arr.slice(i, w)
        curr_max = window.max - window.min
        best_max = curr_max if !best_max || curr_max > best_max
    end
    best_max
end

# Alternative: 
# def windowed_max_range(arr, w)
#     best_max = nil
#     arr.each_with_index do |el, i| 
#         end_idx = i + w - 1
#         break if end_idx > arr.length - 1
#         sub = arr[i..end_idx]
#         curr_max = sub.max - sub.min
#         best_max = curr_max if !best_max || curr_max > best_max
#     end
#     best_max
# end


puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

# Notes: 
# Slice = is O(n), creating new arrays
# Min and Max = each is O(n)