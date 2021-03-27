function heapSort(array) {
    // implement right to left because children (leftIdx and rightIdx in heapify)
    // are always further down in the array
    // heapify subtrees then the tree
    for (let i = array.length - 1; i >= 0; i--) {
        heapify(array, array.length, i)
    }
    // separate heap region (left) and sorted region (right)
    for (let endOfHeap = array.length - 1; endOfHeap >= 0; endOfHeap--) {
        // same as deleteMax and move to right
        swap(array, endOfHeap, 0)
        // restore heap properties
        heapify(array, endOfHeap, 0)
    }
    return array
}

function swap(array, i, j) {
    [ array[i], array[j] ] = [ array[j], array[i] ]
}

// same as siftdown
function heapify(array, n, idx) {
    // we don't have null at idx 0 anymore
    let leftIdx = idx * 2 + 1
    let rightIdx = idx * 2 + 2
    // console.log(leftIdx, rightIdx)
    let leftVal = arr[leftIdx]
    let rightVal = arr[rightIdx]
    
    // we'll have n to check if we're in bound
    if (leftIdx >= n) leftVal = -Infinity
    if (rightIdx >= n) rightVal = -Infinity

    // node is bigger than both children, restored heap
    if (array[idx] > leftVal && array[idx] > rightVal) return

    let swapIdx
    if (leftVal > rightVal) {
        swapIdx = leftIdx
    } else {
        swapIdx = rightIdx
    }
    swap(array, idx, swapIdx)
    heapify(array, n, swapIdx)
}

let arr = [3, 2, 3, 8, 2, 10, 5, 21, 6];
console.log(heapSort(arr))