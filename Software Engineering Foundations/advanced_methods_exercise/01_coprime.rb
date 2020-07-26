# Write a method, coprime?(num_1, num_2), that accepts two numbers as args.
# The method should return true if the only common divisor between the two numbers is 1.
# The method should return false otherwise. For example coprime?(25, 12) is true because
# 1 is the only number that divides both 25 and 12.

def coprime?(num1, num2)
    (2..num1).none? {|num| num1%num == 0 && num2 % num == 0}

    # use of .none?
    # pass each element from 2 to num1, never returns true for all element 

    # arr1 = []
    # arr2 = []
    # (2..num1).each do |num|
    #     if num1 % num == 0
    #         arr1 << num
    #     end
    # end
    # (2..num2).each do |num|
    #     if num2 % num == 0
    #         arr2 << num
    #     end
    # end
    # print arr1
    # print arr2
end

p coprime?(25, 12)    # => true
p coprime?(7, 11)     # => true
p coprime?(30, 9)     # => false
p coprime?(6, 24)     # => false
