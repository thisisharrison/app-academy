require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
      resize! if @count > num_buckets
    end
  end

  def get(key)
    # bucket(key) => LL => LL.get(key) returns val or nil
    bucket(key).get(key) if include?(key)
  end

  def delete(key)
    removed_node = bucket(key).remove(key)
    @count -= 1 if removed_node
    removed_node
  end

  def each
    @store.each do |bucket|
      # bucket.each calls Linked List each method, which yields a node
      bucket.each { |node| yield [node.key, node.val] }
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0
    old_store.each do |bucket|
      bucket.each { |node| set(node.key, node.val) }
    end
  end

  def bucket(key)
    # alias [] to get indexed of linked list
    @store[key.hash % num_buckets]
  end
end
