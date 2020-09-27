# Phase I
# O(n!) factorial time
# O(n!) factorial space: stores n! number of str1 permutation
def first_anagram?(str1, str2)
    str1.split('').permutation.to_a.map(&:join).include?(str2)
end

# Phase 2
# O(n^2) quadratic time - nested operations
# O(n) linear space
def second_anagram?(str1, str2)
    str2_dup = str2.split('')
    str1.each_char do |char|
        idx = str2_dup.find_index(char)
        str2_dup.delete_at(idx) if idx
    end
    str2_dup.empty?
end

# Phase 3
# O(n log n) log linear time - sorting method
# O(n) linear space - size of inputs 
def third_anagram?(str1, str2)
    str1_sort = str1.split('').sort
    str2_sort = str2.split('').sort
    str1_sort == str2_sort
end

# Phase 4
# O(n) linear time - loops the amount of input
# O(1) constant space - max hash size is 26 for all the alphabets
def fourth_anagram?(str1, str2)
    hash1 = Hash.new(0)
    hash2 = Hash.new(0)
    str1.each_char do |char|
        hash1[char] += 1
    end
    str2.each_char do |char|
        hash2[char] += 1
    end
    hash1 == hash2
end

# O(n) linear time
# O(1) constant space
def one_hash_fourth_anagram?(str1, str2)
    hash = Hash.new(0)
    str1.each_char { |char| hash[char] += 1}
    str2.each_char { |char| hash[char] -= 1}
    hash.all? { |k, v| v == 0 }
end

puts one_hash_fourth_anagram?("gizmo", "sally")    #=> false
puts one_hash_fourth_anagram?("elvis", "lives")    #=> true