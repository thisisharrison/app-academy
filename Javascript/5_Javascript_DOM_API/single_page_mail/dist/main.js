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

/***/ "./src/compose.js":
/*!************************!*
  !*** ./src/compose.js ***!
  \************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MessageStore = __webpack_require__(/*! ./message_store */ \"./src/message_store.js\");\n\nconst Compose = {\n    render: () => {\n        const div = document.createElement('div');\n        div.className = 'new-message';\n        div.innerHTML = Compose.renderForm();\n        div.addEventListener('change', (event) => Compose.updateDraft(event));\n        div.addEventListener('submit', (event) => {\n            event.preventDefault();\n            MessageStore.sendDraft();\n            window.location.hash = '#inbox';\n        });\n        return div;\n    },\n\n    renderForm: () => {\n        const draft = MessageStore.getMessageDraft();\n        return `\n            <p class = \"new-message-header\">New Message</p>\n            <form class=\"compose-form\" action=\"\">\n            <input type=\"text\" placeholder=\"Recipient\" name=\"to\" value=\"${draft.to || ''}\">\n            <input type=\"text\" placeholder=\"Subject\" name=\"subject\" value=\"${draft.subject || ''}\">\n            <textarea name=\"body\" rows=\"20\">${draft.body || ''}</textarea>\n            <br>\n            <button type=\"submit\" class=\"btn btn-primary submit-message\">Send</button>\n            </form>\n        `\n    },\n\n    updateDraft: (event) => {\n        const prop = event.target;\n        const name = prop.name;\n        const value = prop.value;\n        MessageStore.updateDraftField(name, value);\n    }\n}\n\nmodule.exports = Compose;\n\n//# sourceURL=webpack://single_page_mail/./src/compose.js?");

/***/ }),

/***/ "./src/inbox.js":
/*!**********************!*
  !*** ./src/inbox.js ***!
  \**********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MessageStore = __webpack_require__(/*! ./message_store */ \"./src/message_store.js\");\n\nconst Inbox = {\n    render: () => {\n        const container = document.createElement('ul');\n        container.className = 'messages';\n        // Get messages from MessageStore\n        const messages = MessageStore.getInboxMessages();\n        messages.forEach((message) => {\n            container.appendChild(Inbox.renderMessage(message));\n        });\n        return container;\n    },\n\n    renderMessage: (message) => {\n        const li = document.createElement('li');\n        li.className = 'message'\n        li.innerHTML = `\n            <span class=\"from\">${message.from}</span>\n            <span class=\"subject\">${message.subject}</span>\n            <span class=\"body\">${message.body}</span>\n        `\n        return li;\n    }\n\n}\n\nmodule.exports = Inbox;\n\n//# sourceURL=webpack://single_page_mail/./src/inbox.js?");

/***/ }),

/***/ "./src/message_store.js":
/*!******************************!*
  !*** ./src/message_store.js ***!
  \******************************/
/***/ ((module) => {

eval("const MessageStore = {\n    getInboxMessages: () => {\n        return messages.inbox.reverse();\n    },\n\n    getSentMessages: () => {\n        return messages.sent.reverse();\n    }, \n\n    getMessageDraft: () => {\n        return messageDraft;\n    }, \n\n    updateDraftField: (field, value) => {\n        // Updates the Message field\n        messageDraft[field] = value;\n    }, \n\n    sendDraft: () => {\n        messages.sent.push(messageDraft);\n        messageDraft = new Message ();\n    }\n}\n\nclass Message {\n    constructor (to, from, subject, body) {\n        this.to = to;\n        this.from = from;\n        this.subject = subject;\n        this.body = body;\n    }\n}\n\n// Draft message\nlet messageDraft = new Message ();\n\n// Seed Data\nlet messages = {\n    sent: [\n        {\n            to: \"friend@mail.com\",\n            subject: \"Check this out\",\n            body: \"It's so cool\"\n        },\n        { to: \"person@mail.com\", subject: \"zzz\", body: \"so booring\" }\n    ],\n    inbox: [\n        {\n            from: \"grandma@mail.com\",\n            subject: \"Fwd: Fwd: Fwd: Check this out\",\n            body:\n                \"Stay at home mom discovers cure for leg cramps. Doctors hate her\"\n        },\n        {\n            from: \"person@mail.com\",\n            subject: \"Questionnaire\",\n            body: \"Take this free quiz win $1000 dollars\"\n        }\n    ]\n};\n\nmodule.exports = MessageStore;\n\n//# sourceURL=webpack://single_page_mail/./src/message_store.js?");

/***/ }),

/***/ "./src/router.js":
/*!***********************!*
  !*** ./src/router.js ***!
  \***********************/
/***/ ((module) => {

eval("class Router {\n    constructor (node, routes) {\n        this.node = node;\n        this.routes = routes;\n    }\n\n    start () {\n        // if someone opens a link to a URL with a hash fragment\n        // or if they refresh with a hash fragment,\n        // the router will still update the DOM.\n        this.render();\n        // Event listener on hashchange\n        window.addEventListener('hashchange', () => this.render());\n    }\n\n    activeRoute () {\n        // Remove the # character\n        const loc = window.location.hash.slice(1);\n        // Returns a component\n        return this.routes[loc];\n    }\n\n    render () {\n        // get component of the current route\n        const component = this.activeRoute();\n        // no component returned\n        if (!component) {\n            this.node.innerHTML = '';\n        } else {\n            this.node.innerHTML = '';\n            const domNode = component.render();\n            this.node.appendChild(domNode);\n        }\n    }\n}\n\nmodule.exports = Router;\n\n\n//# sourceURL=webpack://single_page_mail/./src/router.js?");

/***/ }),

/***/ "./src/sent.js":
/*!*********************!*
  !*** ./src/sent.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MessageStore = __webpack_require__(/*! ./message_store */ \"./src/message_store.js\");\n\nconst Sent = {\n    render: () => {\n        const container = document.createElement('ul');\n        container.className = 'messages';\n        // Get messages from MessageStore\n        const messages = MessageStore.getSentMessages();\n        messages.forEach((message) => {\n            container.appendChild(Sent.renderMessage(message));\n        });\n        return container;\n    },\n\n    renderMessage: (message) => {\n        const li = document.createElement('li');\n        li.className = 'message'\n        li.innerHTML = `\n            <span class=\"to\">${message.to}</span>\n            <span class=\"subject\">${message.subject}</span>\n            <span class=\"body\">${message.body}</span>\n        `\n        return li;\n    }\n\n}\n\nmodule.exports = Sent;\n\n//# sourceURL=webpack://single_page_mail/./src/sent.js?");

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
eval("const Compose = __webpack_require__(/*! ./compose */ \"./src/compose.js\");\nconst Inbox = __webpack_require__(/*! ./inbox */ \"./src/inbox.js\");\nconst Router = __webpack_require__(/*! ./router */ \"./src/router.js\");\nconst Sent = __webpack_require__(/*! ./sent */ \"./src/sent.js\");\n\nconst routes = {\n    \"\": Inbox,\n    inbox: Inbox,\n    sent: Sent,\n    compose: Compose\n}\n\n\ndocument.addEventListener('DOMContentLoaded', () => {\n\n    const sideBar = document.querySelector('.sidebar-nav');\n\n    sideBar.addEventListener('click', (event) => {\n        const loc = event.target.innerText.toLowerCase();\n        window.location.hash = loc;\n    })\n\n    const content = document.querySelector('.content');\n    const router = new Router (content, routes);\n    router.start();\n    // immediately route to inbox\n    window.location.hash = \"#inbox\";\n\n});\n\n\n//# sourceURL=webpack://single_page_mail/./src/index.js?");
})();

/******/ })()
;