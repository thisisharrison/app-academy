// View the full problem and run the test cases at:
//  https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/

class TreeNode {
    constructor(val) {
        this.val = val;
        this.left = null;
        this.right = null;
    }
}

function sortedArrayToBST(nums) {
    if (!nums.length) return null
    
    // find midIdx 
    let midIdx = Math.floor(nums.length / 2)
    // set to root
    let root = new TreeNode(nums[midIdx])
    // traverse left
    root.left = sortedArrayToBST(nums.slice(0, midIdx))
    // traverse right
    root.right = sortedArrayToBST(nums.slice(midIdx + 1))
    return root
}

let nums = [-10, -3, 0, 5, 9];
// Output: [0, -3, 9, -10, null, 5];
console.log(sortedArrayToBST(nums))

nums = [1, 3];
// Output: [3, 1];
console.log(sortedArrayToBST(nums));