// left self right
function inOrderArray(root) {
    if (!root) return []
    return [...inOrderArray(root.left), root.val, ...inOrderArray(root.right)]
}

// left right self
function postOrderArray(root) {
    if (!root) return []
    return [...postOrderArray(root.left), ...postOrderArray(root.right), root.val]
}


module.exports = {
    inOrderArray,
    postOrderArray
};