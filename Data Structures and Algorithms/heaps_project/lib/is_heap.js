// you may assume that the array will always have a null element at the 0-th index
function isMaxHeap(array, idx=1) {
    // empty Heap is a max heap
    if (array[idx] === undefined) return true

    let leftIdx = idx * 2
    let rightIdx = idx * 2 + 1
    let leftVal = array[leftIdx] ? array[leftIdx] : -Infinity
    let rightVal = array[rightIdx] ? array[rightIdx] : -Infinity;
    
    return isMaxHeap(array, leftIdx) && isMaxHeap(array, rightIdx) 
        && array[idx] > leftVal
        && array[idx] > rightVal
}


module.exports = {
    isMaxHeap
};