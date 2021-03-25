class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = null;
        this.right = null;
    }
}

class BST {
    constructor() {
        this.root = null;
    }

    insert(val, root = this.root) {
        // if tree is empty, set node to absolute root
        if (!this.root) {
            this.root = new TreeNode(val)
            return 
        }
        
        if (val < root.val) {
            if (!root.left) {
                // there is no left, so set left to new Node
                root.left = new TreeNode(val)
            } else {
                // this is a left, so recursively look for the right spot
                this.insert(val, root.left)
            }
        } else {
            if (!root.right) {
                root.right = new TreeNode(val)
            } else {
                this.insert(val, root.right)
            }
        }
    }

    searchRecur(val, root = this.root) {
        // we want to return false if recursive call result in an empty root
        if (!root) return false

        if (val < root.val) {
            return this.searchRecur(val, root.left)
        } else if (val > root.val) {
            return this.searchRecur(val, root.right)
        } else {
            return true
        }
    }

    // Constant space by using pointers
    searchIter(val) {
        let pointer = this.root
        
        // pointer is not null
        while (pointer) {
            // less that, set pointer to left subtree
            if (pointer.val < val) {
                pointer = pointer.left
            } else if (pointer.val > val) {
                pointer = pointer.right
            } else {
                return true
            }
        }
        return false
    }
}

module.exports = {
  TreeNode,
  BST,
};
