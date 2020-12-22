/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is not neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./src/dom_node_collection.js":
/*!************************************!*
  !*** ./src/dom_node_collection.js ***!
  \************************************/
/***/ ((module) => {

eval("class DOMNodeCollection {\n    constructor (HTMLelements) {\n        // Each element is a node\n        this.elements = HTMLelements;\n    }\n\n    html (string) {\n        if (string) {\n            return this.elements.map(el => el.innerHTML = string);\n        } else {\n            return this.elements[0].innerHTML;\n        }\n    }\n\n    empty () {\n        this.elements.map(el => el.innerHTML = '');\n        return this;\n    }\n\n    // Traversal elements without #elements.forEach\n    each (cb) {\n        return this.elements.forEach(el => cb(el));\n    }\n\n    first () {\n        return new DOMNodeCollection ([this.elements[0]]);\n    }\n\n    last () {\n        return new DOMNodeCollection(this.elements.slice(-1));\n    }\n\n    append (children) {\n        if (typeof children === 'object' && !(children instanceof DOMNodeCollection)) {\n            // Is a HTMLElement\n            // So create a DOMNodeCollection with it\n            // Handler for DOMNodeCollection will append to parent\n            children = $l(children);\n        }\n        if (typeof children === 'string') {\n            this.elements.map(el => el.innerHTML += children);\n        }\n        if (children instanceof DOMNodeCollection) {\n            let cloneChildren = children;\n            this.each(parent => {\n                cloneChildren.each(child => {\n                    // Returns a duplicate of the node\n                    // appendChild(child) does not work\n                    parent.appendChild(child.cloneNode(true));\n                })\n            })\n        }\n        return this;\n    }\n\n    attr (attributeName, value) {\n        if (value) {\n            // sets value\n            return this.each(el => el.setAttribute(attributeName, value));\n        } else {\n            // gets value\n            return this.elements[0].getAttribute(attributeName);\n        }\n    }\n\n    removeAttr (attributeName) {\n        this.each(el => el.removeAttribute(attributeName));\n    }\n\n    addClass (className) {\n        this.elements.map(el => el.classList.add(className));\n        return this;\n    }\n\n    removeClass (className) {\n        this.elements.map(el => el.classList.remove(className));\n        return this;\n    }\n\n    children () {\n        let allChildren = [];\n        this.each(el => {\n            let nodeChildren = Array.from(el.children);\n            allChildren = allChildren.concat(nodeChildren);\n        })\n        return new DOMNodeCollection (allChildren);\n    }\n\n    length () {\n        return this.elements.length;\n    }\n\n    index (i){\n        return this.elements[i];\n    }\n\n    parent () {\n        let allParents = [];\n        this.each(({ parentNode }) => {\n            if (!parentNode.visited) {\n                // Assign property to track if visited, avoid duplicate parents\n                parentNode.visited = true;\n                allParents.push(parentNode);\n            }\n        })\n        const uniqueNodes = allParents.filter(node => node.visited);\n        return new DOMNodeCollection (uniqueNodes);\n\n        // This will result in two ul if there were 2 li\n        // this.elements.forEach(el => {\n        //     allParents.push(el.parentNode);\n        // })\n        // return new DOMNodeCollection (allParents);\n    }\n\n    find (selector) {\n        let collection = [];\n        this.each((node) => {\n            const el = Array.from(document.querySelectorAll(selector));\n            collection = collection.concat(el);\n        })\n        return new DOMNodeCollection (collection); \n    }\n\n    remove () {\n        this.each((node) => {\n            node.parentNode.removeChild(node);\n        })\n    } \n\n    on (event, cb) {\n        this.each((node) => {\n            node.addEventListener(event, cb);\n            // Store it in the object for method off later\n            const eventKey = `jquerylite-${event}`;\n            if (node[eventKey]) {\n                node[eventKey].push(cb);\n            } else {\n                // add cb to this event\n                node[eventKey] = [cb];\n            }\n        })\n    }\n\n    off (event) {\n        this.each((node) => {\n            const eventKey = `jquerylite-${event}`;\n            if (node[eventKey]) {\n                // remove the listener per event and cb\n                node[eventKey].forEach((cb) => node.removeEventListener(event, cb));\n            } \n            node[eventKey] = [];\n        })\n    }\n}\n\nmodule.exports = DOMNodeCollection;\n\n//# sourceURL=webpack:///./src/dom_node_collection.js?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		if(__webpack_module_cache__[moduleId]) {
/******/ 			return __webpack_module_cache__[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
(() => {
/*!**********************!*
  !*** ./src/index.js ***!
  \**********************/
eval("const DOMNodeCollection = __webpack_require__(/*! ./dom_node_collection */ \"./src/dom_node_collection.js\");\n\n\n// To collect callbacks when Doc Ready\nconst _docReadyCallbacks = [];\nlet _docReady = false;\n\n// $l takes HTML element as arg\n// if not HTML element (i.e. selector), query select from DOM first\n// then create DOMNodeCollection instance\n\nwindow.$l = (arg) => {\n    switch (typeof arg) {\n        // selector (css and html)\n        case 'string': \n            return getNodeFromDOM(arg);\n\n        case 'object': \n            // single HTML or NodeList\n            if (arg instanceof HTMLElement) {\n                return new DOMNodeCollection([arg]);\n            } \n\n        case 'function': \n            return addFunctionQueue(arg);\n    }\n}\n\n$l.merge = (defaults, options) => {\n    for (const k in defaults) {\n        for (const j in options) {\n            if (options[k]) continue;\n            options[k] = defaults[k];\n        }\n    }\n    return options;\n}\n\n$l.ajax = (options) => {\n    const request = new XMLHttpRequest();\n    const defaults = {\n        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', // From jquery docs\n        method: 'GET',\n        url: '',\n        data: {},\n        success: () => { },\n        error: () => { }\n    }\n    $l.merge(defaults, options);\n    \n    // Add search params from data to URL\n    // if (options.method === 'GET') {\n    //     options.url = queryParam(options.data);\n    // }\n\n    request.open(options.method, options.url, true);\n\n    request.onload = (event) => {\n        // Invoke success and error callbacks\n        if (request.status === 200) {\n            options.success(request.response);\n        } else {\n            options.error(request.response);\n        }\n    }\n\n    // Send the ajax request\n    request.send(JSON.stringify(options.data));\n}\n\nfunction queryParam (data) {\n    let params = \"?\"\n    for (const prop in data) {\n        params += `${prop}=${data[prop]}&`;\n    }\n    // Remove last &\n    return params.substring(0, params.length - 1);\n}\n\n\ngetNodeFromDOM = (arg) => {\n    const nodes = document.querySelectorAll(arg);\n    const nodesArray = Array.from(nodes);\n    return new DOMNodeCollection(nodesArray);\n}\n\naddFunctionQueue = (func) => {\n    if (!_docReady) {\n        _docReadyCallbacks.push(func)\n    } else {\n        func();\n    }\n}\n\ndocument.addEventListener('DOMContentLoaded', () => {\n// For _docReady\n    _docReady = true;\n    _docReadyCallbacks.map(func => func());\n\n    $l.ajax({\n        url: \"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=bcb83c4b54aee8418983c2aff3073b3b\",\n        dataType: 'json',\n        success: (resp) => renderResponse(resp),\n        error: (resp) => console.log(resp)\n    })\n\n// For Testing\n    window.$div = $l('div');\n    window.$h1 = $l('h1');\n    window.$p = $l('p');\n    window.$ul = $l('ul');\n    window.$li = $l('li');\n    window.$class = $l('.class');\n    window.$id = $l('#id');\n    window.$checkbox = $l('input[name=\"checkbox\"]');\n});\n\n// Testing out Document Ready\n// $l(()=> alert('ready'));\n\n// Testing out AJAX\nconst renderResponse = (resp) => {\n    const p = document.createElement('p');\n    p.innerHTML = resp;\n    document.querySelector('body').append(p);\n}\n\n\n//# sourceURL=webpack:///./src/index.js?");
})();

/******/ })()
;