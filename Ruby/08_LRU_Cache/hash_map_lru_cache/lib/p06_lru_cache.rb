require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :max, :prc, :map, :store

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # calc sets map[key] to nodes
    # node.val gets val
    if @map[key]
      node = @map[key]
      update_node!(node)
      node.val
    else
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = prc.call(key)
    # adds to end of list 
    new_node = @store.append(key, val)
    # map[key] points to node and get O(1) time
    @map[key] = new_node
    # have we exceeded the cache size
    eject! if count > @max
    # return val
    val
  end

  def update_node!(node)
    # unlink the prev and next
    node.remove 
    # node.prev.next = node.next
    # node.next.prev = node.prev
    
    # gets accessed, move node to end of the list
    @map[node.key] = @store.append(node.key, node.val)
    # @store.tail.prev = node
    # node.next = @store.tail
  end

  def eject!
    # node after head #first
    removing_node = @store.first
    # unlinke the prev and next
    # O(1) time 
    removing_node.remove
    # hashmap deletes the ket 
    # O(1) time 
    @map.delete(removing_node.key)
  end
end
