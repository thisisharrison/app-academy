require_relative "02_mystack"

class MinMaxStack
    def initialize(store = [])
        @store = MyStack.new
    end

    def peek
        # MyStack peek - last in array of values 
        @store.peek[:value] unless empty?
    end

    def size
        @store.size
    end

    def empty?
        @store.empty?
    end

    def push(el)
        # O(1) with hash 
        @store.push({
            max: new_max(el),
            min: new_min(el),
            value: el
        })
    end
    
    def pop
        @store.pop[:value] unless empty?
    end

    def max
        @store.peek[:max] unless empty?
    end

    def min
        @store.peek[:min] unless empty?
    end

    private
    def new_max(el)
        # calls function max to peek historical max then compare el to find max
        empty? ? el : [max, el].max 
    end

    def new_min(el)
        empty? ? el : [min, el].min
    end
end

# Notes:
# @store.peek[:symbol] it will look at, for eg.,  
# [{:max=>2, :min=>2, :value=>2}, {:max=>2, :min=>0, :value=>0}]
# [:max] will be [2,2]