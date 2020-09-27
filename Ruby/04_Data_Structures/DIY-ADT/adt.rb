 # Stack - LIFO
 class Stack
    def initialize
        @array = []
    end

    def push(el)
        @array.push(el)
    end

    def pop
        @array.pop
    end

    def peek
        @array.last
    end
end

# Queue - FIFO
class Queue
    def initialize 
        @array = []
    end

    def enqueue(el)
        @array.push(el)
    end
    
    def dequeue
        @array.shift
    end
    
    def peek
        @array.first
    end
end

# Map
class Map
    def initialize
        @array = []
    end

    def set(key, value = '')
        idx = @array.index { |sub| sub[0] == key }
        if idx 
            # Change key's value if key exists
            @array[idx][1] = value
        else
            # Create Key and Value if key doesn't exist
            @array.push([key, value])
        end
        return value
    end
    
    def get(key)
        @array.each do |sub|
            return sub[1] if sub[0] == key
        end
        return nil
    end

    def delete(key)
        value = get(key)
        @array.reject! { |sub| 
            sub[0] == key
        }
        value
    end
    
    def show
        deep_dup(@array)
    end

    def deep_dup(array)
        array.map { |el| 
            if el.is_a?(Array)
                deep_dup(el)
            else
                el
            end
        }
    end

    # def delete(key)
    #     @array.each_with_index do |sub, i|
    #         if sub[0] == key
    #             @array.delete_at(i)
    #     end
    #     return nil
    # end
end