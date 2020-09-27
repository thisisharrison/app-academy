class MaxIntSet
  attr_reader :store
  
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    validate!(num)
    # not allow duplicates
    return false if @store[num]
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    return nil unless include?(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  attr_reader :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return false if include?(num)
    self[num] << num
    num
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    # % will wrap around 20, go into the bucket, find num 
    # call self[] to access @store with bucket
    self[num].include?(num)
  end

  private

  def [](num)
    # % the buckets will give us indices within the bucket range
    # so we can call #[] and stay within range 
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    self[num] << num 
    @count += 1
    resize! if @count > num_buckets
    num
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # make a copy to insert later
    old_store = @store
    # reset
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    # [[]] to [] then insert each num
    old_store.flatten.each { |num| insert(num) }
  end
end
