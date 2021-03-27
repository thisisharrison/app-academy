function numRegions(graph) {
    let visited = new Set ();
    let regions = 0;
    for (let node in graph) {
        if (depthFirst(node, graph, visited)) regions++
    }
    return regions
}

function depthFirst(node, graph, visited) {
    // if we have visited return false, we dont' want to add to the regions
    if (visited.has(node)) return false
    visited.add(node)

    // traverse all the connected neighbor in a region
    // return true after traversing so we can add to the region count
    graph[node].forEach(neighbor => {
        depthFirst(neighbor, graph, visited)
    })
    return true
}

module.exports = {
    numRegions
};