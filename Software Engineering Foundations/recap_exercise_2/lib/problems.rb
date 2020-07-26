# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
def least_common_multiple(num_1, num_2)

    (1..num_1 * num_2).each do |i| # num_1 * num_2 because their product is a common multiple 
        return i if i % num_1 == 0 && i % num_2 == 0 # multiple of both 
    end

end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    new_hash = Hash.new(0)

    (0...str.length).each do |i|
        new_hash[str[i..i+1]] += 1 if i < str.length-1
    end

    sorted = new_hash.sort_by{|k, v| v} # sort by value, returns a 2D array

    sorted.last[0]

end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        new_hash = {}

        self.each do |k, v|
            new_hash[v] = k
        end

        new_hash
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0

        self.each_with_index do |num_1, idx_1|
            self.each_with_index do |num_2, idx_2|
                if num_1 + num_2 == num && idx_2 > idx_1
                    count += 1
                end
            end
        end

        count
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)
    def bubble_sort(&prc)

        prc ||= Proc.new{|a, b| a <=> b} # nil (users' proc) or our proc, our proc takes in 2 args and <=> them, we won't overwrite their arg as well
        
        sorted = false

        while !sorted
            sorted = true

            (0...self.length-1). each do |i|
                if prc.call(self[i], self[i+1]) == 1 # proc call our a <=> b or users' like { |a, b| a.to_s <=> b.to_s }, either way if == 1, then sort them
                    sorted = false
                    self[i], self[i+1] = self[i+1], self[i] 
                end
            end

        end

        return self
    end
end

