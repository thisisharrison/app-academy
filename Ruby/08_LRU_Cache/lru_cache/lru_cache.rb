class LRUCache
    attr_reader :size, :array
    def initialize(size = 1)
        @size = size
        @cache = []
    end

    def count
        # returns number of elements currently in cache
        @cache.count
    end

    # O(n) linear time 
    def add(el)
        # adds element to cache according to LRU principle
        duplicate?(el)
        @cache.shift if count >= size
        @cache << el 
    end

    def show
        # shows the items in the cache, with the LRU item first
        p @cache
    end

    private
    # make sure @cache is a Set and no duplicates
    def duplicate?(el)
        @cache.delete(el) if @cache.include?(el)
    end
end

if __FILE__ == $PROGRAM_NAME
    johnny_cache = LRUCache.new(4)

    johnny_cache.add("I walk the line")
    johnny_cache.add(5)

    p johnny_cache.count # => returns 2

    johnny_cache.add([1,2,3])
    johnny_cache.add(5)
    johnny_cache.add(-5)
    johnny_cache.add({a: 1, b: 2, c: 3})
    johnny_cache.add([1,2,3,4])
    johnny_cache.add("I walk the line")
    johnny_cache.add(:ring_of_fire)
    johnny_cache.add("I walk the line")
    johnny_cache.add({a: 1, b: 2, c: 3})
    johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]
end