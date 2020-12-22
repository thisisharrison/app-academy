class DOMNodeCollection {
    constructor (HTMLelements) {
        // Each element is a node
        this.elements = HTMLelements;
    }

    html (string) {
        if (string) {
            return this.elements.map(el => el.innerHTML = string);
        } else {
            return this.elements[0].innerHTML;
        }
    }

    empty () {
        this.elements.map(el => el.innerHTML = '');
        return this;
    }

    // Traversal elements without #elements.forEach
    each (cb) {
        return this.elements.forEach(el => cb(el));
    }

    first () {
        return new DOMNodeCollection ([this.elements[0]]);
    }

    last () {
        return new DOMNodeCollection(this.elements.slice(-1));
    }

    append (children) {
        if (typeof children === 'object' && !(children instanceof DOMNodeCollection)) {
            // Is a HTMLElement
            // So create a DOMNodeCollection with it
            // Handler for DOMNodeCollection will append to parent
            children = $l(children);
        }
        if (typeof children === 'string') {
            this.elements.map(el => el.innerHTML += children);
        }
        if (children instanceof DOMNodeCollection) {
            let cloneChildren = children;
            this.each(parent => {
                cloneChildren.each(child => {
                    // Returns a duplicate of the node
                    // appendChild(child) does not work
                    parent.appendChild(child.cloneNode(true));
                })
            })
        }
        return this;
    }

    attr (attributeName, value) {
        if (value) {
            // sets value
            return this.each(el => el.setAttribute(attributeName, value));
        } else {
            // gets value
            return this.elements[0].getAttribute(attributeName);
        }
    }

    removeAttr (attributeName) {
        this.each(el => el.removeAttribute(attributeName));
    }

    addClass (className) {
        this.elements.map(el => el.classList.add(className));
        return this;
    }

    removeClass (className) {
        this.elements.map(el => el.classList.remove(className));
        return this;
    }

    children () {
        let allChildren = [];
        this.each(el => {
            let nodeChildren = Array.from(el.children);
            allChildren = allChildren.concat(nodeChildren);
        })
        return new DOMNodeCollection (allChildren);
    }

    length () {
        return this.elements.length;
    }

    index (i){
        return this.elements[i];
    }

    parent () {
        let allParents = [];
        this.each(({ parentNode }) => {
            if (!parentNode.visited) {
                // Assign property to track if visited, avoid duplicate parents
                parentNode.visited = true;
                allParents.push(parentNode);
            }
        })
        const uniqueNodes = allParents.filter(node => node.visited);
        return new DOMNodeCollection (uniqueNodes);

        // This will result in two ul if there were 2 li
        // this.elements.forEach(el => {
        //     allParents.push(el.parentNode);
        // })
        // return new DOMNodeCollection (allParents);
    }

    find (selector) {
        let collection = [];
        this.each((node) => {
            const el = Array.from(document.querySelectorAll(selector));
            collection = collection.concat(el);
        })
        return new DOMNodeCollection (collection); 
    }

    remove () {
        this.each((node) => {
            node.parentNode.removeChild(node);
        })
    } 

    on (event, cb) {
        this.each((node) => {
            node.addEventListener(event, cb);
            // Store it in the object for method off later
            const eventKey = `jquerylite-${event}`;
            if (node[eventKey]) {
                node[eventKey].push(cb);
            } else {
                // add cb to this event
                node[eventKey] = [cb];
            }
        })
    }

    off (event) {
        this.each((node) => {
            const eventKey = `jquerylite-${event}`;
            if (node[eventKey]) {
                // remove the listener per event and cb
                node[eventKey].forEach((cb) => node.removeEventListener(event, cb));
            } 
            node[eventKey] = [];
        })
    }
}

module.exports = DOMNodeCollection;