function breadthFirstArray(root) {
    const queue = [ root ] // FIFO
    const result = []
    while (queue.length) {
        let node = queue.shift() // get oldest element
        result.push(node.val)
        
        if (node.left) queue.push(node.left) // left to right
        if (node.right) queue.push(node.right)
    }
    return result
}

module.exports = {
    breadthFirstArray
};