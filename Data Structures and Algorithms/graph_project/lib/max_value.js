function maxValue_0(node, visited=new Set(), max=null) {
    // return negative infinity as it won't be bigger than anything else
    if (visited.has(node)) return -Infinity

    // memo max
    max = Math.max(max, node.val)
    // add to set
    visited.add(node)
    // depth first traverse all nodes
    node.neighbors.forEach(neighbor => {
        max = Math.max(maxValue(neighbor, visited, max), max)
    })

    // return max
    return max
}

// much cleaner code
function maxValue(node, visited=new Set()) {
    
    if (visited.has(node)) return -Infinity
    // add to set
    visited.add(node)
    // depth first traverse all nodes, create array of maxes
    let neighborsMaxes = node.neighbors.map(neighbor => maxValue(neighbor, visited))

    // find max in the neighbors maxes and self
    return Math.max(...neighborsMaxes, node.val);
}

module.exports = {
    maxValue
};