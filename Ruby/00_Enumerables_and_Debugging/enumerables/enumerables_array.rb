require "byebug"

class Array
    def my_each(&prc)
        self.length.times do |i|
            prc.call(self[i])
        end
        self
    end
    # not allowed to use each, then x times product (0..x).each 

    def my_select(&prc)
        selected = []
        self.my_each do |item|
            selected << item if prc.call(item)
        end
        selected
    end

    def my_reject(&prc)
        rejected = []
        self.my_each do |item|
            rejected << item if !prc.call(item)
        end
        rejected
    end

    def my_any?(&prc)
        self.my_each do |item|
            return true if prc.call(item)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |item|
            return false if !prc.call(item)
        end
        true
    end

    def my_flatten
        flattened = []

        self.my_each do |sub|
            if sub.is_a?(Array)
                flattened.concat(sub.my_flatten)
            else
                flattened << sub
            end
        end
        return flattened
    end

    def my_zip(*args)
        zipped = []
        
        self.length.times do |i|
            subzip = [self[i]]

            args.my_each do |array|
                subzip << array[i]
            end

            zipped << subzip
        end
        zipped
    end

    def my_rotate(n=1)
        split_i = n % self.length # -ve n after % return +ve n
        self.drop(split_i) + self.take(split_i) 
    end

    

    # def my_rotate(n=1)
    #     rotated = []

    #     self.length.times do |i|
    #         new_i = (i + n) % self.length
    #         rotated << self[new_i]
    #     end

    #     rotated
    # end

    def my_join(n="")
        joined = ""
        self.my_each do |i|
            joined += i + n
        end
        joined
    end

    def my_reverse
        reversed = []
        self.my_each do |el|
            debugger 
            reversed.unshift(el)
        end
        reversed
    end
end

# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
#   debugger
# end
# # => 1
#      2
#      3
#      1
#      2
#      3

# p return_value  # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_select { |num| num > 1 } # => [2, 3]
# p a.my_select { |num| num == 4 } # => []

# a = [1, 2, 3]
# p a.my_reject { |num| num > 1 } # => [1]
# p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# a = [1, 2, 3]
# p a.my_any? { |num| num > 1 } # => true
# p a.my_any? { |num| num == 4 } # => false
# p a.my_all? { |num| num > 1 } # => false
# p a.my_all? { |num| num < 4 } # => true

# p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
# p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
# p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

# c = [10, 11, 12]
# d = [13, 14, 15]
# p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# a = [ "a", "b", "c", "d" ]
# p a.my_rotate         #=> ["b", "c", "d", "a"]
# p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# a = [ "a", "b", "c", "d" ]
# p a.my_join         # => "abcd"
# p a.my_join("$")    # => "a$b$c$d"

# a = [1, 2, 3, 4, 5, 0]
# a.drop(3)             #=> [4, 5, 0]
# a = [1, 2, 3, 4, 5, 0]
# a.take(3)             #=> [1, 2, 3]

# p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
# p [ 1 ].my_reverse               #=> [1]

# Prepends objects to the front of self, moving other elements upwards.
# See also Array#shift for the opposite effect.

#    a = [ "b", "c", "d" ]
#    a.unshift("a")   #=> ["a", "b", "c", "d"]