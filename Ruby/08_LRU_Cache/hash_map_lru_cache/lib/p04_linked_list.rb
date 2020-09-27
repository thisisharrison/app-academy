class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # previous node should point to my next node
    @prev.next = @next if @prev
    # next node should point to my prev node
    @next.prev = @prev if @next
    @next = nil
    @prev = nil
    self
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    # if list is empty, then first is nil, otherwise, it's the next node head is pointing to
    empty? ? nil : @head.next
  end

  def last
    # if list is empty, then last is nil, otherwise, it's the prev node of tail
    empty? ? nil : @tail.prev
  end

  def empty?
    # nothing in between head and tail, list is empty
    @head.next == @tail
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    # with Enumerable
    any? { |node| node.key == key }
    # each do |node|
    #   return true if node.key == key
    # end
    # false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    # tail's previous node points to new node
    @tail.prev.next = new_node
    # new node point to tail's previous node
    new_node.prev = @tail.prev
    # new node next point to tail
    new_node.next = @tail
    # tail's previous is new node 
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    each do |node|
      # each calls node, node passed to this method
      if node.key == key
        node.val = val
        return node
      end
    end
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.remove
        return node.val
      end
    end
    # if no key
    nil
  end

  def each
    current_node = @head.next
    until current_node == @tail
      # #yield to the block that uses each #update, #remove, #get. Use the current_node in those blocks. each {...}.
      # Then return to the code here, and we go to next node. 
      yield current_node
      # after block executed, next node
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
