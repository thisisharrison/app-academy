// ============================================================================
// Implementation Exercise: Singly Linked List
// ============================================================================
//
// -------
// Prompt:
// -------
//
// Implement a Singly Linked List and all of its methods below!
//
// ------------
// Constraints:
// ------------
//
// Make sure the time and space complexity of each is equivalent to those 
// in the table provided in the Time and Space Complexity Analysis section
// of your Linked List reading!
//
// -----------
// Let's Code!
// -----------

// TODO: Implement a Linked List Node class here
class Node {
    constructor(val) {
        this.value = val;
        this.next = null;
    }

}

// TODO: Implement a Singly Linked List class here
class LinkedList {
    constructor() {
        this.head = null;
        this.tail = null;
        this.length = 0;
    }

    // Adds a new node to the tail of the Linked List.
    addToTail(val) {
        const newTail = new Node (val);
        if (!this.head) {
            this.head = newTail;
        } else {
            // old tail points to newTail
            this.tail.next = newTail;
        }
        // set tail to newTail
        this.tail = newTail;
        this.length++;
        // return full list
        return this;
    }

    // Removes the node at the tail of the Linked List.
    removeTail() {
        if (!this.head) return undefined;
        let current = this.head
        let newTail = current
        // stops on the last node
        while (current.next) {
            newTail = current
            current = current.next
        }
        this.tail = newTail
        this.tail.next = null
        this.length--;
        if (this.length === 0) {
            this.head = null
            this.tail = null
        }
        return current
    }

    // Adds a new node to the head of the Linked List.
    addToHead(val) {
        const newHead = new Node (val);
        if (!this.head) {
            this.head = newHead;
            this.tail = newHead;
        } else {
            // place it before this.head and set next to old head
            newHead.next = this.head;
            this.head = newHead;
        }
        this.length++;
        return this;
    }

    // Removes the node at the head of the Linked List.
    removeHead() {
        if (!this.head) return undefined;
        const currentHead = this.head;
        this.head = currentHead.next;
        this.length--;
        // removed all elements
        if (this.length === 0) {
            this.tail = null;
        }
        return currentHead;
    }

    // Searches the Linked List for a node with the value specified.
    contains(target) {
        let pointer = this.head
        while (pointer) {
            if (pointer.value === target) {
                return true;
            }
            pointer = pointer.next
        }
        return false;
    }

    // Gets the node at the "index", or position, specified.
    get(index) {
        if (index < 0 || index >= this.length) return null;
        let i = 0
        let pointer = this.head
        while (i !== index) {
            i++;
            pointer = pointer.next;
        }
        return pointer;
    }

    // Updates the value of a node at the "index", or position, specified.
    set(index, val) {
        let target = this.get(index);
        if (target) {
            target.value = val;
            return true;
        }
        return false;
    }

    // Inserts a new node at the "index", or position, specified.
    insert(index, val) {
        if (index < 0 || index >= this.length) return false;
        if (index === 0) return !!this.addToHead(val);
        if (index === this.length) !!this.addToTail(val);
        
        const newNode = new Node (val)
        let prev = this.get(index - 1)
        let prevNext = prev.next
        prev.next = newNode;
        newNode.next = prevNext;
        this.length++;
        return true;
    }

    // Removes the node at the "index", or position, specified.
    remove(index) {
        if (index < 0 || index >= this.length) return undefined;
        if (index === 0) return this.removeHead();
        if (index === this.length - 1) return this.removeTail();

        const prev = this.get(index - 1)
        const toRemove = prev.next;
        prev.next = toRemove.next;
        this.length--;
        return toRemove;
    }

    // Returns the current size of the Linked List. 
    size() {
        return this.length;
    }
}

exports.Node = Node;
exports.LinkedList = LinkedList;
