# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.
require "byebug"

def largest_prime_factor(number)
    number.downto(2) do |factor|
        if number % factor == 0 && is_prime?(factor)
            return factor
        end
    end

    # i = number
    # while i > 0
    #     if number % i == 0 && is_prime?(i)
            
    #         return i 
    #     end
    #     i -= 1 ## Replaced with .downto
    # end
end

def is_prime?(number)
    return false if number < 2
    (2...number).none? {|i| number % i == 0} # none of the numbers in the range is true

    # if number < 2
    #     return false
    # end
    # (2...number).each do |i|
    #     if number % i == 0
    #         return false
    #     end
    # end
    # true
end

def unique_chars?(string)
    array = string.split("")
    original = array.length
    new_arr = array.uniq.length
    original == new_arr

    # seen = []
    # string.each_char do |char|
    #     if seen.include?(char)
    #         return false
    #     end
    #     seen << char
    # end
    # return true
end
  

def dupe_indices(array)
    hash = Hash.new { |h, k| h[k] = [] }
    # hash = Hash.new {Array.new} => this doesn't work
    array.each_with_index do |char, i|
        hash[char] << i
    end
    hash.select { |key, array| array.length > 1} # choose from hash where hash[key] has an array greater than 1 
end


def ana_array(arr_1, arr_2)
    arr_count(arr_1) == arr_count(arr_2) # in ruby, hashes can equal and order is not important, unlike arrays
end

def arr_count(arr)
    hash = Hash.new(0)
    arr.each do |ele|
        hash[ele] += 1
    end
    hash
end 
