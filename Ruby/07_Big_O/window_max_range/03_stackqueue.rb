require_relative "02_mystack"

class StackQueue
    def initialize
        @in_stack = MyStack.new
        @out_stack = MyStack.new
    end

    def size
        @in_stack.size + @out_stack.size
    end

    def empty?
        @in_stack.empty? && @out_stack.empty?
    end

    def enqueue(el)
        @in_stack.push(el)
    end

    def dequeue
        queueify if @out_stack.empty?
        @out_stack.pop
    end

    private 
    def queueify
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end
end
