def element_count(arr)
    count = Hash.new(0)
    arr.each {|ele| count[ele] += 1}
    count
end

def char_replace!(str, hash)
    str.each_char.with_index do |char, i|
        str[i] = hash[char] if hash.has_key?(char)
    end
    str
end

def product_inject(arr)
    arr.inject {|product, num| product * num}
end
