// View the full problem and run the test cases at:
//  https://leetcode.com/problems/balanced-binary-tree/


function isBalanced(root) {
    if (!root) return true
    
    // height of left 
    let left = getHeight(root.left)
    // height of right
    let right = getHeight(root.right)
    
    // left - right is at most 1
    let heightDiff = Math.abs(left - right) <= 1
    
    // also check their subtrees recursively
    return heightDiff && isBalanced(root.left) && isBalanced(root.right)
}

function getHeight(root) {
    if (!root) return -1
    return 1 + Math.max(getHeight(root.left), getHeight(root.right))
}