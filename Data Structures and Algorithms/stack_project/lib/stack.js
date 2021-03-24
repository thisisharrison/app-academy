// ============================================================================
// Implementation Exercise: Stack
// ============================================================================
//
// -------
// Prompt:
// -------
//
// Implement a Stack and all of its methods below!
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

class Stack {
    constructor() {
        this.top = null
        this.bottom = null
        this.length = 0
    }
    // Insertion - Adds a Node to the top of the Stack. - Integer - New size of stack
    push(val) {
        const newNode = new Node (val)
        if (!this.top) {
            this.top = newNode
            this.bottom = newNode
        } else {
            newNode.next = this.top
            this.top = newNode
        }
        this.length++
        return this.length
    }
    // Deletion	- Removes a Node from the top of the Stack.	- Node removed from top of Stack
    pop() {
        if (!this.top) return null
        const removed = this.top
        if (this.length === 1) {
            this.top = null
            this.bottom = null
        } else {
            this.top = removed.next
        }
        this.length--
        return removed.value
    }
    // Meta	- size - Returns the current size of the Stack. - Integer
    size() {
        return this.length
    }
}

exports.Node = Node;
exports.Stack = Stack;
