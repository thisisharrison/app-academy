# FIFO
class MyQueue
    def initialize(store = [])
        @store = store
    end

    def peek 
        @store.last
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def enqueue(el)
        @store.push(el)
    end

    def dequeue
        @store.shift
    end
end

# Notes:
# Every time we move the window, we could enqueue the next element and dequeue the last element. 
# This would allow us to avoid using Array#slice, so that we can traverse the array in constant time.