const { GraphNode } = require('./graph_node');

function depthFirstRecur (node, targetVal, visited = new Set ()) {
    if (visited.has(node)) return

    if (node.val === targetVal) return node
    
    let result = null
    let temp = null
    visited.add(node)
    node.neighbors.forEach(neighbor => {
        temp = depthFirstRecur(neighbor, targetVal, visited)
        if (temp) result = temp
    })

    return result
}

// let a = new GraphNode("a");
// let b = new GraphNode("b");
// let c = new GraphNode("c");
// a.neighbors = [b, c];

// console.log(depthFirstRecur(a, "x")) // null
// console.log(depthFirstRecur(a, "c")) // c
// console.log(depthFirstRecur(a, "a")) // a


let a = new GraphNode("a");
let b = new GraphNode("b");
let c1 = new GraphNode("c");
c1.name = 'c1'
let c2 = new GraphNode("c");
c2.name = 'c2'
a.neighbors = [b, c1];
b.neighbors = [c2];
console.log(depthFirstRecur(a, "c").name) // c1, WORKS

let s = new GraphNode("s");
let t = new GraphNode("t");
s.neighbors = [t];
t.neighbors = [s];
console.log(depthFirstRecur(s, "q")) // null

let u = new GraphNode("u");
let v = new GraphNode("v");
let w = new GraphNode("w");
u.neighbors = [v];
v.neighbors = [u, w];
console.log(depthFirstRecur(u, "w")) // w