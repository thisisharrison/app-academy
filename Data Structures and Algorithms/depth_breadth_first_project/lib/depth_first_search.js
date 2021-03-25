function depthFirstSearch(root, targetVal) {
    const stack = [ root ] // LIFO
    while (stack.length) {
        let node = stack.pop() // the last item
        if (node.val === targetVal) {
            return node
        }
        if (node.right) stack.push(node.right)
        if (node.left) stack.push(node.left) // we want left go first, push after right
    }
    return null
}



module.exports = {
    depthFirstSearch
};