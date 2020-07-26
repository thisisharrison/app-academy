def my_reject(arr, &prc)
    arr.select {|ele| !prc.call(ele)}
end

    
def my_one?(arr, &prc)
    arr.count(&prc) == 1
    # new_arr = arr.select {|ele| prc.call(ele)}
    # new_arr.length == 1
end
    
def hash_select(hash, &prc)
    new_hash = {}
    hash.each do |k, v| 
        new_hash[k] = v if prc.call(k, v)
    end
    new_hash
end

def xor_select(arr, prc_1, prc_2)
    arr.select {|ele| !prc_1.call(ele) && prc_2.call(ele) || prc_1.call(ele) && !prc_2.call(ele) }
end

def proc_count(value, array)
    array.count {|prc| prc.call(value)}
    # count = 0
    # array.each do |prc|
    #     count += 1 if prc.call(value)
    # end
    # count
end