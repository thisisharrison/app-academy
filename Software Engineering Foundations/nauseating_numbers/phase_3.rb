# Phase 3: Now we're having fun.
def matrix_addition(m1, m2)
    height = m1.length 
    width = m1[0].length
    result = Array.new(height) {[0] * width}

    (0...height).each do |row|
        (0...width).each do |col|
            result[row][col] = m1[row][col] + m2[row][col]
        end
    end
    result
end

def matrix_addition_reloaded(*matrices)
    return nil if !matrices.all?{|matrix| matrices.first.length == matrix.length}
    matrix = matrices.first # eg. get matrix_a
    height = matrix.length
    width = matrix[0].length # eg. [2,5]

    empty_matrix = Array.new(height) {[0] * width} # look at structurally diagram, how many subs = height, how many ele = width
    matrices.inject(empty_matrix) do |m1, m2|
        matrix_addition(m1, m2)
    end
end

# # structurally
# 2 5  +  9 1  =>  11 6
# 4 7     3 0      7 7

# Examples
# matrix_a = [[2,5], [4,7]]
# matrix_b = [[9,1], [3,0]]
# matrix_c = [[-1,0], [0,-1]]
# matrix_d = [[2, -5], [7, 10], [0, 1]]
# matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
# p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
# p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
# p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil

def squarocol?(grid)
    return true if grid.any? {|row| row.uniq.length == 1 } # satisfies a row of same symbol
    return true if grid.transpose.any? {|col| col.uniq.length == 1} # satisfies a col of same symbol
    return false 

    # transpose result = [[:a, :b, :c], [:x, :x, :x], [:d, :e, :f]]
end

# Examples

# p squarocol?([
#     [:a, :x , :d],
#     [:b, :x , :e],
#     [:c, :x , :f],
# ]) # true

# p squarocol?([
#     [:x, :y, :x],
#     [:x, :z, :x],
#     [:o, :o, :o],
# ]) # true

# p squarocol?([
#     [:o, :x , :o],
#     [:x, :o , :x],
#     [:o, :x , :o],
# ]) # false

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 7],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # true

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 0],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # false


def squaragonal?(grid)
    height = grid.length - 1
    
    # rotate left 
    i = 0
    new_grid = []
    while i <= height
        new_grid << grid[i].rotate(i)
        i += 1
    end
    
    if new_grid.transpose.any? {|col| col.uniq.length == 1} 
        true
    else
        # rotate right 
        i = 0
        new_grid = []
        while i <= height
            new_grid << grid[i].rotate(-i)
            i += 1
        end
        new_grid.transpose.any? {|col| col.uniq.length == 1} 
    end
end


# Examples
# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :x, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :o, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 7],
#     [1, 1, 6, 7],
#     [0, 5, 1, 7],
#     [4, 2, 9, 1],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 5],
#     [1, 6, 5, 0],
#     [0, 2, 2, 7],
#     [5, 2, 9, 7],
# ]) # false

def adjacent_sum(arr)
    new_arr = []
    (0...arr.length - 1).each do |i|
        new_arr << arr[i]+arr[i+1]
    end
    new_arr
end

def pascals_triangle(n)
    triangle = [[1]]
    level = 1

    while level < n
        level_above = triangle.last
        next_level = [1]
        next_level += adjacent_sum(level_above)
        next_level << 1
        triangle << next_level
        level += 1
    end

    triangle
end

# Examples
p pascals_triangle(5)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1]
# ]

p pascals_triangle(7)
# [
#     [1],
#     [1, 1],
#     [1, 2, 1],
#     [1, 3, 3, 1],
#     [1, 4, 6, 4, 1],
#     [1, 5, 10, 10, 5, 1],
#     [1, 6, 15, 20, 15, 6, 1]
# ]