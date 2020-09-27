require "byebug"
# Max Window Range
require_relative "05_minmaxstackqueue"

def windowed_max_range(arr, window_size)
    queue = MinMaxStackQueue.new
    best_max = nil
    arr.each do |el|
        
        queue.enqueue(el)
        if queue.size > window_size
            # keeping total count of window size stacks
            # each stack holds the metadata of min and max
            # using enqueue and dequeue to slice the array 
            queue.dequeue
        end
        if queue.size == window_size
            curr_max = queue.max - queue.min    
            best_max = curr_max if !best_max || curr_max > best_max
        end
    end
    best_max
end

puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8