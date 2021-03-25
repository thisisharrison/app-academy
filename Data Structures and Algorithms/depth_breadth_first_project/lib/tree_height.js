function treeHeight(root, max = 0) {
    // depth first because we want to find the maximum edge
    if (!root) return -1
    if (!root.right && !root.left) return 0
    
    let left = 1 + treeHeight(root.left) // count our current edge, 1+ 
    let right = 1 + treeHeight(root.right)
    
    // console.log(left, right)
    // compare which is longest
    return Math.max(left, right)
}


module.exports = {
    treeHeight
};