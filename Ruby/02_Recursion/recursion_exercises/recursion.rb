require "byebug"
# Warm Up
def range(num_1, num_2)
    return [] if num_2 < num_1
    [num_1] + range(num_1 + 1, num_2)
end

def iterative_sum_array(arr)
    arr.inject do |acc, el|
        acc += el
    end
end

def recursive_sum_array(arr)
    return arr.first if arr.length == 1
    recursive_sum_array(arr[0...-1]) + arr[-1]
end

# Exponentiation 

def exp(base, exponent)
    return 1 if exponent == 0
    base * exp(base, exponent - 1)
end

# recursion 1
# exp(b, 0) #= 1
# exp(b, n) #= b * exp(b, n - 1)

def exp_2(base, exponent)
    return 1 if exponent == 0
    # debugger
    half = exp_2(base, exponent / 2)

    if exponent.even?
        half * half
    else
        base * half * half
    end
end

# recursion 2
# exp_2(b, 0) #= 1
# exp_2(b, 1) #= b
# exp_2(b, n) #= exp(b, n / 2) ** 2             [for even n]
# exp_2(b, n) #= b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

# Deep Dup

class Array
    def deep_dup
        return self unless self.is_a?(Array)
        return [] if self.empty?
        new_array = []
        self.each do |el| 
            new_array << (el.is_a?(Array) ? el.deep_dup : el)
        end
        new_array
    end
end

# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]

# robot_parts_copy = robot_parts.deep_dup

# # shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# p robot_parts[1] # => ["capacitors", "resistors", "inductors"]

# Fibonacci

def fib_rec(n)
    return [1,1].take(n) if n <= 2
    return [] if n < 1

    fibs = fib_rec(n - 1)
    fibs << fibs[-2] + fibs[-1]

end 

def fib_iter(n)
    return [1,1].take(n) if n <= 2
    return [] if n < 1
    fibs = [1, 1]
    while fibs.length < n
        fibs << fibs[-2] + fibs[-1]
    end
    fibs
end

# Binary Search

def bsearch(arr, target)
    return nil if arr.empty?

    half = arr.length / 2

    case target <=> arr[half]
    # target smaller
    when -1
        bsearch(arr.take(half), target)
    # target greater
    when 1
        sub_answer = bsearch(arr.drop(half + 1), target)
        sub_answer.nil? ? nil : half + 1 + sub_answer
    # target equals
    when 0
        half
    end
    
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

# Merge Sort

def merge_sort(arr)
    debugger
    return [arr[0]] if arr.length == 1
    half = arr.length / 2
    left = merge_sort(arr.take(half))
    right = merge_sort(arr.drop(half))
    merge(left, right)
end

def merge(left, right)
    merged = []
    # compare left and right, either shifted to merged will return empty and then can a merge together
    until left.empty? || right.empty?
        if left.first < right.first
            merged << left.shift
        else
            merged << right.shift
        end
    end
    merged + left + right
end

# p merge_sort([76, 6, 65, 12, 4, 29, 10, 6])
# p merge_sort([2, 10, 6, 7, 5, 3, 1, 9, 4, 8])

class Array
    def subsets
        return [[]] if empty?
        length = count - 1
        subs = take(length).subsets
        subs.concat(subs.map { |sub| sub + [last] })
    end

    def permutations
        return [self] if length <= 1

        # take out first ele
        first_el = [shift]
        perms = self.permutations

        total = []
        # return of perms add back first el
        perms.each do |perm|
            (0..perm.length).each do |i|
                total << perm[0...i] + first_el + perm[i..-1]
            end
        end
        total
    end
end

# p [].subsets # => [[]]
# p [1].subsets # => [[], [1]]
# p [1, 2].subsets # => [[], [1], [2], [1, 2]]
# p [1, 2, 3].subsets
# # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

# p [1, 2, 3].permutations # => [[1, 2, 3], [1, 3, 2],
#                         #     [2, 1, 3], [2, 3, 1],
#                         #     [3, 1, 2], [3, 2, 1]]

def iter_make_change(amount, coins=[25,10,5,1])
    change = []
    coins.each do |coin|
        count = amount / coin
        count.times { change << coin}
        amount = amount - count * coin
    end
    change
end

def rec_make_change(amount, coins=[25,10,5,1])
    change = []

    coin = coins.shift
    count = amount / coin
    count.times { change << coin }
    amount = amount - count * coin

    if amount > 0
        change += rec_make_change(amount,coins)
    end
    change
end

def make_better_change(amount, coins=[25,10,5,1])
    return [] if amount == 0

    best_change = nil
    
    coins.each do |coin|
        next if coin > amount

        change_for_rest = make_better_change(amount - coin, coins)
        change = [coin] + change_for_rest

        if best_change.nil? || change.count < best_change.count 
            best_change = change
        end
    end
    best_change
end


# p arr = iter_make_change(99)
# p arr.sum
# p arr2 = rec_make_change(99)
# p arr2.sum
# p arr3 = make_better_change(99, [25,10,5,1])
# p arr3.sum
# p arr3 = make_better_change(14, [10,7,1])
# p arr3.sum