class MaxHeap {
    constructor() {
        this.array = [null]
    }
    
    insert(val) {
        this.array.push(val)
        this.siftUp(this.array.length - 1)
    }

    getLeftChild(idx) {
        return idx * 2
    }

    getRightChild(idx) {
        return idx * 2 + 1
    }

    getParent(idx) {
        return Math.floor(idx / 2)
    }

    siftUp(idx) {
        // we're at root
        if (idx === 1) return
        
        let parentIdx = this.getParent(idx)

        if (this.array[idx] > this.array[parentIdx]) {
            [this.array[parentIdx], this.array[idx]] = [this.array[idx], this.array[parentIdx]];
            this.siftUp(parentIdx);
        }
    }

    deleteMax() {
        if (this.array.length === 2) return this.array.pop()
        if (this.array.length === 1) return null
        
        let max = this.array[1]
        this.array[1] = this.array.pop()
        this.siftDown(1)
        return max
    }

    siftDown(idx) {
        let arr = this.array
        let leftIdx = this.getLeftChild(idx)
        let rightIdx = this.getRightChild(idx)
        let leftVal = arr[leftIdx]
        let rightVal = arr[rightIdx]
        
        if (!leftVal) leftVal = -Infinity
        if (!rightVal) rightVal = -Infinity

        // node is bigger than both children, restored heap
        if (arr[idx] > leftVal && arr[idx] > rightVal) return

        let swapIdx
        if (leftVal > rightVal) {
            swapIdx = leftIdx
        } else {
            swapIdx = rightIdx
        }
        [ arr[idx], arr[swapIdx] ] = [ arr[swapIdx], arr[idx] ]
        this.siftDown(swapIdx)
    }

}

module.exports = {
    MaxHeap
};