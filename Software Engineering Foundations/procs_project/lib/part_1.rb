def my_map(array, &prc)
    result = []
    array.each do |ele|
        result << prc.call(ele) # shuffle result of proc
    end
    result
end

def my_select(array, &prc)
    result = []
    array.each do |ele|
        result << ele if prc.call(ele) # only shuffle true ele
    end
    result
end
  
def my_count(array, &prc)
    counter = 0
    array.each do |ele|
        counter += 1 if prc.call(ele)
    end
    counter
end

def my_any?(array, &prc)
    array.each do |ele|
        if prc.call(ele)
            return true
        end
    end
    false
end

def my_all?(array, &prc)
    array.each do |ele|
        if !prc.call(ele)
            return false
        end
    end
    true
end
   
def my_none?(array, &prc)
    array.each do |ele|
        if prc.call(ele)
            return false
        end
    end
    true
end
