# FILO
class MyStack
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

    def push(el)
        @store.push(el)
    end
    
    def pop
        @store.pop
    end
end

# Notes:
# Removing items from MyQueue takes O(n) time. 
# As the first element of the array is shifted off, 
# the remaining elements will be reassigned in new position in memory. 
# Also, it still leaves us with the problem of expensive min and max operations.