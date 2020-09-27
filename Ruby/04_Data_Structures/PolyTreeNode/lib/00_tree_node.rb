class PolyTreeNode
    
    attr_reader :parent, :children, :value
    
    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(node)
        # No change is made
        return if self.parent == node 
        
        # Removing self from the old parent
        if self.parent 
            self.parent._children.delete(self)
        end

        # Make node its' new parent
        @parent = node

        # Add self to new parent's children unless I'm the root
        self.parent._children << self unless self.parent.nil?
        
        self
        
    end

    # Access to node's children for #parent=(node)
    def _children
        @children
    end

    def add_child(child_node)
        child_node.parent = self
    end
    
    def remove_child(child_node)
        # If child_node is valid and it's not my child
        if child_node && !self.children.include?(child_node)
            raise "Child is not mine"
        end
        child_node.parent = nil
    end

    def dfs(target)
        return self if self.value == target
        # My children each do a DFS search
        @children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result.nil?
        end
        nil
    end
    
    def bfs(target)

        queue = [self]
        until queue.empty?
            # FIFO, first one gets processed
            el = queue.shift
            return el if el.value == target
            # Enqueue for each of the children
            el.children.each { |child| 
                queue << child
            }
        end

        nil
    end
end