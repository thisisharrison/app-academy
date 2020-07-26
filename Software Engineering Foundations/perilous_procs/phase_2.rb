# Phase 2: The proc thickens.

def xnor_select(arr, prc_1, prc_2)
    selected = []
    arr.each do |ele|
        selected << ele if (prc_1.call(ele) && prc_2.call(ele)) || (!prc_1.call(ele) && !prc_2.call(ele))
    end
    selected
end

# Examples
# is_even = Proc.new { |n| n % 2 == 0 }
# is_odd = Proc.new { |n| n % 2 != 0 }
# is_positive = Proc.new { |n| n > 0 }
# p xnor_select([8, 3, -4, -5], is_even, is_positive)         # [8, -5]
# p xnor_select([-7, -13, 12, 5, -10], is_even, is_positive)  # [-7, -13, 12]
# p xnor_select([-7, -13, 12, 5, -10], is_odd, is_positive)   # [5, -10]

def filter_out!(arr, &prc)
    arr.uniq.each {|ele| arr.delete(ele) if prc.call(ele)}
end

# perilous_procs $ ruby phase_2.rb => without uniq
# [1, 7, 3, 5]
# 1
# [7, 3, 5]
# 3
# [7, 5]
# perilous_procs $ ruby phase_2.rb => with uniq, each arr starts from [0] and get evaluated
# [1, 7, 3, 5]
# 1
# [7, 3, 5]
# 7
# [3, 5]
# 3
# [5]
# 5
# []

# Examples
# arr_1 = [10, 6, 3, 2, 5 ]
# filter_out!(arr_1) { |x| x.odd? }
# p arr_1     # [10, 6, 2]

# arr_2 = [1, 7, 3, 5 ]
# filter_out!(arr_2) { |x| x.odd? }
# p arr_2     # []

# arr_3 = [10, 6, 3, 2, 5 ]
# filter_out!(arr_3) { |x| x.even? }
# p arr_3     # [3, 5]

# arr_4 = [1, 7, 3, 5 ]
# filter_out!([1, 7, 3, 5 ]) { |x| x.even? }
# p arr_4 # [1, 7, 3, 5]

def multi_map(arr, n = 1, &prc) # run through n times, default is 1 time
    new_arr = []
    arr.each do |ele|
        n.times { ele = prc.call(ele)}
        new_arr << ele
    end
    new_arr
end

# Examples
# p multi_map(['pretty', 'cool', 'huh?']) { |s| s + '!'}      # ["pretty!", "cool!", "huh?!"]
# p multi_map(['pretty', 'cool', 'huh?'], 1) { |s| s + '!'}   # ["pretty!", "cool!", "huh?!"]
# p multi_map(['pretty', 'cool', 'huh?'], 3) { |s| s + '!'}   # ["pretty!!!", "cool!!!", "huh?!!!"]
# p multi_map([4, 3, 2, 7], 1) { |num| num * 10 }             # [40, 30, 20, 70]
# p multi_map([4, 3, 2, 7], 2) { |num| num * 10 }             # [400, 300, 200, 700]
# p multi_map([4, 3, 2, 7], 4) { |num| num * 10 }             # [40000, 30000, 20000, 70000]

def proctition(arr, &prc)
    trues = []
    falses = []

    arr.each do |ele| 
        if prc.call(ele)
            trues << ele 
        else
            falses << ele 
        end
    end

    [*trues, *falses]

end

# Examples
# p proctition([4, -5, 7, -10, -2, 1, 3]) { |el| el > 0 }
# # [4, 7, 1, 3, -5, -10, -2]

# p proctition([7, 8, 3, 6, 10]) { |el| el.even? }
# # [8, 6, 10, 7, 3]

# p proctition(['cat','boot', 'dog', 'bug', 'boat']) { |s| s[0] == 'b' }
# # ["boot", "bug", "boat", "cat", "dog"]