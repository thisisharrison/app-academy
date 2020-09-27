require_relative "04_minmaxstack"

class MinMaxStackQueue

    def initialize
        @in_stack = MinMaxStack.new
        @out_stack = MinMaxStack.new
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

    # min and max compares metadata of in_stack and out_stack to get the historical min and max
    def min
        mins = []
        mins << @in_stack.min unless @in_stack.empty?
        mins << @out_stack.min unless @out_stack.empty?
        mins.min
    end

    def max
        maxs = []
        maxs << @in_stack.max unless @in_stack.empty?
        maxs << @out_stack.max unless @out_stack.empty?
        maxs.max
    end

    private 
    def queueify
        @out_stack.push(@in_stack.pop) until @in_stack.empty?
    end


end
