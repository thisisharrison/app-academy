class KnightPathFinder
    
    # For build_move_tree
    attr_reader :start_pos
    
    # Knights can only move up, down, left, right X 2 then right or left X 1
    MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]
  
    def self.valid_moves(pos)
        valid_moves = []
        x, y = pos

        MOVES.each do |move| 
            a, b = move
            new_pos = [x + a, y + b]

            # within the board?
            if new_pos.all? { |coor| coor.between?(0,7) }
                valid_moves << new_pos
            end
        end
        valid_moves
    end

    def initialize(start_pos)
        @start_pos = start_pos
        @considered_pos = [start_pos]
        
        build_move_tree
    end

    attr_accessor :root_node, :considered_pos

    def build_move_tree
        self.root_node = PolyTreeNode.new(start_pos)
        
        nodes = [root_node]

        until nodes.empty?
            curr_node = nodes.shift
            # calling their value with PolyTreeNode
            curr_pos = curr_node.value

            # make children 
            self.new_move_positions(curr_pos).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                curr_node.add_child(next_node)
                nodes << next_node
            end
        end
    end

    def new_move_positions(pos)
        KnightPathFinder.valid_moves(pos)
            .reject { |pos| @considered_pos.include?(pos) }
            .each { |new_pos| @considered_pos << new_pos }
    end

    def trace_path_back(end_node)
        path = []
        
        curr_node = end_node

        # stop until path includes start_pos
        until path.include?(start_pos)    
            # shuffle the pos to path
            path << curr_node.value
            # find it's parent and shuffle it next
            curr_node = curr_node.parent
        end
        # reverse path so start_pos at the beginning 
        path.reverse
    end

    def find_path(end_pos)
        # gives us end_pos node or nil if not a possible move
        end_node = root_node.dfs(end_pos)

        trace_path_back(end_node)
    end
end

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

if __FILE__ == $PROGRAM_NAME
    k = KnightPathFinder.new([0, 0])
    p k.find_path([7, 6])
    p k.find_path([6, 2])
end