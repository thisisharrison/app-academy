def proper_factors(num)
    (1...num).select do |factor|
        num % factor == 0
    end
end

def aliquot_sum(num)
    proper_factors(num).sum
end

def perfect_number?(num)
    num == aliquot_sum(num)
end

def ideal_numbers(n)
    count = []
    num = 1
    while count.length < n
        count << num if perfect_number?(num)
        num += 1
    end
    count
end