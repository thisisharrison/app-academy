# Phase 2: Nothing you can't handle.
def num_factors(num)
    (2..num).count {|n| num % n == 0}
end

def anti_prime?(num)
    amount = num_factors(num)
    (1...num).all? {|i| amount > num_factors(i)} 
end

# Examples
# p anti_prime?(24)   # true
# p anti_prime?(36)   # true
# p anti_prime?(48)   # true
# p anti_prime?(360)  # true
# p anti_prime?(1260) # true
# p anti_prime?(27)   # false
# p anti_prime?(5)    # false
# p anti_prime?(100)  # false
# p anti_prime?(136)  # false
# p anti_prime?(1024) # false

def matrix_addition(arr_1, arr_2)
    result = []
    (0...arr_2.length).each do |sub|
        temp = []
        length = arr_2[sub].length
        (0...length).each do |i|
            temp << arr_1[sub][i] + arr_2[sub][i]
        end
        result << temp
    end
    result
end

# Examples
matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
# p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
# p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
# p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]

def factors(num)
    (1..num).select {|n| num % n == 0}
end

def mutual_factors(*nums)
    nums.map {|num| factors(num)}.inject(:&)
end

# Array#& => [1,2,3] & [2,4,6] = [2]
# Inject takes the first array #& to second array, then result of that #& the next one


# Examples
# p mutual_factors(50, 30)            # [1, 2, 5, 10]
# p mutual_factors(50, 30, 45, 105)   # [1, 5]
# p mutual_factors(8, 4)              # [1, 2, 4]
# p mutual_factors(8, 4, 10)          # [1, 2]
# p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
# p mutual_factors(12, 24, 64)        # [1, 2, 4]
# p mutual_factors(22, 44)            # [1, 2, 11, 22]
# p mutual_factors(22, 44, 11)        # [1, 11]
# p mutual_factors(7)                 # [1, 7]
# p mutual_factors(7, 9)              # [1]


def tribonacci_number(num)
    tri = [1, 1, 2]
    while tri.length <= num
        tri << tri[-3..-1].sum
    end
    tri[num-1]
end

# Examples
# p tribonacci_number(1)  # 1
# p tribonacci_number(2)  # 1
# p tribonacci_number(3)  # 2
# p tribonacci_number(4)  # 4
# p tribonacci_number(5)  # 7
# p tribonacci_number(6)  # 13
# p tribonacci_number(7)  # 24
# p tribonacci_number(11) # 274