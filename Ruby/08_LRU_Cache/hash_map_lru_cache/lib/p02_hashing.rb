class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    # specified initial value with aggregate
    each_with_index.inject(0) do |aggregate, (el, i)|
      # XOR 
      # 2 ^ 3 == 1
      # And we can get back 2 and 3
      # 1 ^ 2 == 3
      # 1 ^ 3 == 2
      (el.hash + i.hash) ^ aggregate
    end
  end
end

class String
  def hash
    # #ord - ASCII of the char
    chars.map(&:ord).hash
  end
end

class Hash
  def hash
    # utilizing Array#hash
    to_a.sort_by{ |subarray| subarray.hash }.hash
  end
end
