// View the full problem and run the test cases at:
//  https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/

const { TreeNode } = require('./tree_node.js');


function buildTree(preorder, inorder) {
    // base case
    if (preorder.length === 0 || inorder.length === 0) return null
    
    const rootVal = preorder[0]
    const root = new TreeNode (rootVal)
    
    // find index of root in inorder
    let midIdx = inorder.findIndex(val => val === rootVal)
    // slice inorder right and left using midIdx - because inorder is left, root, right
    let leftInOrder = inorder.slice(0, midIdx)
    let rightInOrder = inorder.slice(midIdx + 1)

    // inorder and preorder should have same value, construct preorder
    let leftPreOrder = preorder.filter(val => leftInOrder.includes(val))
    let rightPreOrder = preorder.filter(val => rightInOrder.includes(val))

    // get the left and right subtrees
    const left = buildTree(leftPreOrder, leftInOrder)
    const right = buildTree(rightPreOrder, rightInOrder)
    // assign with root
    root.left = left
    root.right = right

    return root
}

let preorder = [3,9,20,15,7]
let inorder = [9,3,15,20,7]

console.log(buildTree(preorder, inorder))

// TreeNode {
//   val: 3,
//   left: TreeNode { val: 9, left: null, right: null },
//   right: TreeNode {
//     val: 20,
//     left: TreeNode { val: 15, left: null, right: null },
//     right: TreeNode { val: 7, left: null, right: null }
//   }
// }

/*
preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
preorder = root, left, right
inorder = left, root, right

root = 3

        3
    9       20
        15      7
*/
/*
preorder = a
inorder = a

    a

preorder = a, b
inorder = b, a

    a
b

preorder = a, b
inorder = a, b

    a
        b
*/
