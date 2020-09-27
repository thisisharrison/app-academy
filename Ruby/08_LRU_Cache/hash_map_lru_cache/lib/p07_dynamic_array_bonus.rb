class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  
  include Enumerable

  attr_accessor :count, :start_idx, :store

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @start_idx = 0
  end

  def [](i)
    # index doesn't exist
    if i >= @count
      return nil 
    elsif i < 0
      # index doesn't exist
      return nil if i < -@count
      # [-1] = count - 1 index = last element
      return self[@count + i]
    end
    # wrap around to get index
    @store[(@start_idx + i) % capacity]
  end

  def []=(i, val)
    # eg [1,2,nil,nil,5]
    if i >= @count 
      # eg [1,2,nil,nil,nil] then add 5 at the end
      (i - @count).times { push(nil) }
    elsif i < 0
      # index doesn't exist
      return nil if i < -@count 
      return self[@count + i] = val
    end

    if i == @count 
      resize! if @count >= capacity
      @count += 1
    end

    @store[(@start_idx + i) % capacity] = val

  end

  def capacity
    @store.length
  end

  def include?(val)
    any? { |el| el == val }
  end

  def push(val)
    resize! if @count == capacity
    @store[(@start_idx + @count) % capacity] = val
    @count += 1
    self
  end

  def unshift(val)
    resize! if @count == capacity
    # the val is end of the store, but that's the start_idx now
    # subsequently shifts every el 
    @start_idx = (@start_idx - 1) % capacity
    @store[@start_idx] = val
    @count += 1
    self
  end

  def pop
    # nothing to pop
    return nil if @count == 0
    # get last item => count - 1 
    last_item = @store[(@start_idx + @count - 1) % capacity]
    # @count tracking the indices, this item's [] is lost (?)
    @count -= 1
    last_item
  end

  def shift
    # nothing to shift 
    return nil if @count == 0
    @count -= 1
    # get first item
    first_item = @store[@start_idx]
    # el old start_idx is shifted. +1 to old idx and % to stay within range
    @start_idx = (@start_idx + 1) % capacity
    first_item
  end

  def first
    return nil if @count == 0
    @store[@start_idx]
  end

  def last
    return nil if @count == 0
    @store[(@start_idx + @count - 1) % capacity]
  end

  def each
    # using count and self[i] to navigate the array
    @count.times { |i| yield self[i] }
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless length == other.length
    each_with_index { |el, i| return false unless el == other[i] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    # move self over to placeholder first 
    each_with_index { |el, i| new_store[i] = el }
    # then set self to new_store
    @store = new_store
    @start_idx = 0
  end
end