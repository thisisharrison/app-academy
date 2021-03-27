function breadthFirstSearch(startingNode, targetVal) {
    let visited = new Set ()
    // breadth first, FIFO
    let queue = [ startingNode ]

    while (queue.length) {
        let node = queue.shift()
        // this node was visited continue to next loop
        if (visited.has(node.val)) continue
        // check if targetVal matches
        if (node.val === targetVal) return node
        // add to visited stack
        visited.add(node.val)
        // push and spread the neighbors array
        queue.push(...node.neighbors)
    }
    return null
}


module.exports = {
    breadthFirstSearch
};