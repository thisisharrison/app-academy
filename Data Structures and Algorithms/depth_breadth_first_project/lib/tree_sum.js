function treeSum(root) {
    if (!root) return 0
    // recursion - stack - depth first
    // evaluate left first
    return root.val + treeSum(root.left) + treeSum(root.right)
}

function treeSum_breadth_first(root) {
    if (!root) return 0
    // breadth first
    const queue = [ root ]
    let sum = 0
    while (queue.length) {
        let node = queue.shift()
        sum += node.val
        if (node.left) queue.push(node.left)
        if (node.right) queue.push(node.right)
    }
    return sum
}

module.exports = {
    treeSum
};