 def is_prime?(num)
    return false if num < 2
    (2...num).each do |factor|
        return false if num % factor == 0
    end
    true
 end
    
def nth_prime(num)
    count = 0
    n = 1
    while count < num
        n += 1 # hence 1st prime is 2
        count += 1 if is_prime?(n)
    end
    n
end

def prime_range(min, max)
    (min..max).select {|ele| is_prime?(ele)}
end

