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

/***/ "./src/apple.js":
/*!**********************!*
  !*** ./src/apple.js ***!
  \**********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Coord = __webpack_require__(/*! ./coord */ \"./src/coord.js\");\n\nclass Apple {\n    constructor (board) {\n        this.board = board;\n        this.placeRandom();\n    }\n\n    placeRandom () {\n        let x = Math.floor(Math.random() * this.board.DIM_X);\n        let y = Math.floor(Math.random() * this.board.DIM_Y);\n\n        while (this.board.snake.isOccupying([x, y])) {\n            x = Math.floor(Math.random() * this.board.DIM_X);\n            y = Math.floor(Math.random() * this.board.DIM_Y);\n        }\n\n        this.position = new Coord(x, y);\n        return this.position;\n    }\n}\n\nmodule.exports = Apple;\n\n//# sourceURL=webpack:///./src/apple.js?");

/***/ }),

/***/ "./src/board.js":
/*!**********************!*
  !*** ./src/board.js ***!
  \**********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Snake = __webpack_require__(/*! ./snake */ \"./src/snake.js\");\nconst Apple = __webpack_require__(/*! ./apple */ \"./src/apple.js\");\n\nclass Board {\n    constructor (dim_x, dim_y) {\n        this.DIM_X = dim_x;\n        this.DIM_Y = dim_y;\n        \n        this.snake = new Snake (this);\n        this.apple = new Apple (this);\n    }\n\n    blankGrid () {\n        return Array.from({ length: Board.DIM_X }, row => Array.from( {length: Board.DIM_Y }));\n    }\n\n    validCoord (coord) {\n        return this.valid(coord.x, this.DIM_X) && this.valid(coord.y, this.DIM_Y)\n    }\n\n    valid (i, max) {\n        return i >= 0 && i < max;\n    }\n}\n\nBoard.DIM_X = 15;\nBoard.DIM_Y = 10;\n\n\n\nmodule.exports = Board;\n\n//# sourceURL=webpack:///./src/board.js?");

/***/ }),

/***/ "./src/coord.js":
/*!**********************!*
  !*** ./src/coord.js ***!
  \**********************/
/***/ ((module) => {

eval("class Coord {\n    constructor (x, y) {\n        this.x = x;\n        this.y = y;\n    }\n    \n    plus (p2) {\n        return new Coord (this.x + p2.x, this.y + p2.y);\n    }\n\n    equals (p2) {\n        return this.x === p2.x && this.y === p2.y;\n    }\n\n    isOpposite (p2) {\n        return this.x === -1 * p2.x && this.y === -1 * p2.y;\n    }\n\n    wrap (max_x, max_y) {\n        this.x = this.wrapping(this.x, max_x);\n        this.y = this.wrapping(this.y, max_x);\n    }\n\n    wrapping (og, max) {\n        let _new;\n        if (og > max) {\n            _new = max % og;\n        }\n        else if (og < 0) {\n            _new = max - (og % max)\n        } else {\n            _new = og;\n        }\n        return _new;\n    }\n}\n\nmodule.exports = Coord;\n\n//# sourceURL=webpack:///./src/coord.js?");

/***/ }),

/***/ "./src/snake-view.js":
/*!***************************!*
  !*** ./src/snake-view.js ***!
  \***************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Board = __webpack_require__(/*! ./board */ \"./src/board.js\");\n\nclass View {\n    constructor ($el) {\n        this.$el = $el;\n        \n        // Flexible game size depend on window\n        let x, y;\n        [x, y] = this.screenSize();\n        this.DIM_X = x;\n        this.DIM_Y = y;\n\n        this.board = new Board (x, y);\n        // Paints Board \n        this.setUpGrid();\n        // Control snake moves\n        this.bindKeys();\n        // Renders every half second\n        this.intervalId = window.setInterval(\n            this.step.bind(this),\n            500\n        )\n    }\n\n    screenSize () {\n        const dim_x = Math.floor($(window).width() * 0.4 / 20);\n        const dim_y = Math.floor($(window).height() * 0.8 / 20);\n        return [dim_x, dim_y];\n    }\n\n    bindKeys () {\n        $(window).on('keydown', this.handleKeyEvent.bind(this));\n    }\n\n    handleKeyEvent (event) {\n        if (View.KEYS[event.keyCode]) {\n            this.board.snake.turn(View.KEYS[event.keyCode])\n        }\n    }\n\n    step () {\n        if (this.board.snake.move()) {\n            this.render();\n        } else {\n            window.clearInterval(this.intervalId);\n            this.isOver();\n        }\n    }\n\n    isOver () {\n        const $figcaption = $('<figcaption>');\n        $figcaption.html('Game Over');\n        $figcaption.insertAfter(this.$el);\n    }\n\n    setUpGrid () {\n        const grid = this.board.blankGrid();\n        const $div = $('<div>').addClass('board');\n        for (let row = 0; row < this.DIM_X; row++) {\n            const $ul = $('<ul>');\n            for (let col = 0; col < this.DIM_Y; col++) {\n                const $li = $('<li>');\n                $ul.append($li);\n            }\n            $div.append($ul);\n        }\n        this.$el.append($div);\n        this.render();\n    }\n    \n    render () {\n        // Reset\n        this.$el.find('li').removeClass();\n\n        this.board.snake.segments.map((coord) => {\n            this.updateClass(coord, 'snake');\n        });\n\n        this.updateClass(this.board.apple.position, 'apple');\n    }\n\n    updateClass (coord, type) {\n        // first row or tenth row plus index in that row\n        const $row = this.$el.find('ul').eq(coord.x);\n        const $col = $row.find('li').eq(coord.y);\n\n        $col.addClass(type);\n    }\n}\n\nView.KEYS = {\n    38: 'N',\n    40: 'S',\n    37: 'W',\n    39: 'E'\n}\n\nmodule.exports = View;\n\n//# sourceURL=webpack:///./src/snake-view.js?");

/***/ }),

/***/ "./src/snake.js":
/*!**********************!*
  !*** ./src/snake.js ***!
  \**********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Coord = __webpack_require__(/*! ./coord */ \"./src/coord.js\");\nconst Board = __webpack_require__(/*! ./board */ \"./src/board.js\");\n\nclass Snake {\n    constructor (board) {\n        this.dir = 'N';\n        this.wrappable = false;\n        this.board = board;\n        \n        const center = new Coord (Math.floor(board.DIM_X / 2), Math.floor(board.DIM_Y / 2));\n        this.segments = [center];\n        this.growth = 0;\n    }\n\n    head () {\n        return this.segments.slice(-1)[0];\n    }\n\n    body () {\n        return this.segments.slice(0, -1);\n    }\n\n    move () {\n        // move forward \n        let new_seg = this.head().plus(Snake.DIFF[this.dir]);\n\n        if (this.wrappable) {\n            // wrap if exceed boarder\n            this.segments.push(new_seg.wrap(this.board.DIM_X, this.board.DIM_Y));\n        } else {\n            this.segments.push(new_seg);\n        }\n        \n        this.eatsApple();\n\n        // Each interval grow 1 block\n        if (this.growth > 0) {\n            this.growth -= 1;\n        } \n        else {\n            this.segments.shift();\n        }\n\n        if (this.isOver()) {\n            // this.segments = [];\n            return false;\n        } else {\n            return true;\n        }\n    }\n\n    turn (dir) {\n        // Should not turn to itself\n        if (Snake.DIFF[this.dir].isOpposite(Snake.DIFF[dir])) {\n            return;\n        } else {\n            this.dir = dir;\n        }\n    }\n\n    isOver () {\n        if (this.hitWall()) {\n            return true\n        }\n        return this.hitSelf();\n    }\n\n    // Something's not right\n    hitWall () {\n        if (!this.board.validCoord(this.head())) {\n            return true;\n        };\n    }\n\n    hitSelf () {\n        return this.body().some(coord => coord.equals(this.head()));\n    }\n\n    // To not place apple on snake body\n    isOccupying (coord) {\n        let x, y;\n        [x, y] = coord;\n        let pos = new Coord(x, y);\n        return this.segments.some(c => c.equals(pos));\n    }\n\n    eatsApple () {\n        if (this.head().equals(this.board.apple.position)) {\n            this.growth += 3; \n            this.board.apple.placeRandom();\n            return true;\n        }\n    }\n}\n\nSnake.DIFF = {\n    'N': new Coord (-1, 0),\n    'E': new Coord (0, 1),\n    'W': new Coord (0, -1),\n    'S': new Coord (1, 0)\n}\n\nmodule.exports = Snake;\n\n//# sourceURL=webpack:///./src/snake.js?");

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
eval("const View = __webpack_require__(/*! ./snake-view */ \"./src/snake-view.js\");\n\n$(() => {\n    console.log('ready');\n    const rootEl = $('.grid');\n    new View (rootEl);\n});\n\n//# sourceURL=webpack:///./src/index.js?");
})();

/******/ })()
;