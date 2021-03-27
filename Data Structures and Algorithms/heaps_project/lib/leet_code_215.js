// https://leetcode.com/problems/kth-largest-element-in-an-array/
const { MaxHeap } = require("./max_heap");

function findKthLargest(nums, k) {
    let heap = new MaxHeap();
    nums.forEach(num => heap.insert(num))
    // kth largest meaning if k =5 we deleteMax 4 times, the next time is kth largest
    for (let i = 1; i < k; i++) heap.deleteMax()
    // this is the kth element
    return heap.deleteMax()
};

let nums = [3,2,3,1,2,4,5,5,6]
let k = 4
// Output: 4
console.log(findKthLargest(nums, k))