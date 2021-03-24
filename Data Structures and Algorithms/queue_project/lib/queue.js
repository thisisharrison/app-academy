// ============================================================================
// Implementation Exercise: Queue
// ============================================================================
//
// -------
// Prompt:
// -------
//
// Implement a Queue and all of its methods below!
//
// ------------
// Constraints:
// ------------
//
// Make sure the time and space complexity of each is equivalent to those 
// in the table provided in the Time and Space Complexity Analysis section
// of your Stack reading!
//
// -----------
// Let's Code!
// -----------

class Node {
    constructor(val) {
        this.value = val
        this.next = null
    }
}

class Queue {
    constructor() {
        this.front = null
        this.back = null
        this.length = 0
    }
    // Insertion - Adds a Node to the back of the Queue.	Integer - New size of Queue
    enqueue(val) {
        const newNode = new Node (val)
        if (!this.front) {
            this.front = newNode
            this.back = newNode
        } else {
            this.back.next = newNode
            this.back = newNode 
        }
        this.length++
        return this.length
    }
    // Deletion - Removes a Node from the front of the Queue.	Node removed from front of Queue
    dequeue() {
        if (!this.front) return null
        const removed = this.front
        if (this.length === 1) {
            this.front = null
            this.back = null
        } else {
            this.front = removed.next
        }
        this.length--
        return removed.value
    }
    // Meta	- Returns the current size of the Queue.	Integer
    size() {
        return this.length
    }
}

exports.Node = Node;
exports.Queue = Queue;