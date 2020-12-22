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

/***/ "./src/asteroid.js":
/*!*************************!*
  !*** ./src/asteroid.js ***!
  \*************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Util = __webpack_require__(/*! ./util */ \"./src/util.js\");\nconst MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\nconst Ship = __webpack_require__(/*! ./ship */ \"./src/ship.js\");\nconst Bullet = __webpack_require__(/*! ./bullet */ \"./src/bullet.js\");\n\nconst DEFAULTS = {\n    RADIUS: 25,\n    COLOR: \"#000000\"\n};\n\nfunction Asteroid (options) {\n    options = options || {}\n    options.pos = options.pos;\n    options.color = DEFAULTS.COLOR;\n    options.radius = DEFAULTS.RADIUS;\n    options.vel = Util.randomVec(10);\n    options.game = options.game;\n    \n    // Call to access code inside MovingObject, like Ruby's super\n    MovingObject.call(this, options);\n}\n// Sets up prototype chain inheritance\nUtil.inherits(Asteroid, MovingObject);\n\nAsteroid.prototype.collideWith = function (otherObject) {\n    if (otherObject instanceof Ship) {\n        otherObject.relocate ();\n        return true;\n    } else if (otherObject instanceof Bullet) {\n        this.remove();\n        otherObject.remove();\n        return true;\n    }\n    return false;\n}\n\nmodule.exports = Asteroid;\n\n//# sourceURL=webpack:///./src/asteroid.js?");

/***/ }),

/***/ "./src/bullet.js":
/*!***********************!*
  !*** ./src/bullet.js ***!
  \***********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\nconst Util = __webpack_require__(/*! ./util */ \"./src/util.js\");\n\nconst DEFAULT = {\n    RADIUS: 3,\n    COLOR: \"#6AFC08\", \n}\n\nBullet.SPEED = 15;\n\nfunction Bullet (options) {\n    options = options || {};\n    options.pos = options.pos;\n    options.color = DEFAULT.COLOR;\n    options.radius = DEFAULT.RADIUS;\n    options.vel = options.vel;\n    options.game = options.game;\n\n    MovingObject.call(this, options);\n}\n\nUtil.inherits(Bullet, MovingObject);\n\nBullet.prototype.isWrappable = false;\n    \nmodule.exports = Bullet;\n\n//# sourceURL=webpack:///./src/bullet.js?");

/***/ }),

/***/ "./src/game.js":
/*!*********************!*
  !*** ./src/game.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Asteroid = __webpack_require__(/*! ./asteroid */ \"./src/asteroid.js\");\nconst Util = __webpack_require__(/*! ./util */ \"./src/util.js\");\nconst Ship = __webpack_require__(/*! ./ship */ \"./src/ship.js\");\nconst Bullet = __webpack_require__(/*! ./bullet */ \"./src/bullet.js\");\n\nfunction Game () {\n    this.asteroids = [];\n    this.addAsteroids();\n    this.ships = [];\n    this.bullets = [];\n}\n\nGame.DIM_X = 1000;\nGame.DIM_Y = 600;\nGame.NUM_ASTEROIDS = 10;\n\nGame.prototype.allObjects = function () {\n    a = [].concat(this.asteroids, this.ships, this.bullets);\n    return a;\n}\n\nGame.prototype.add = function (obj) {\n    if (obj instanceof Asteroid) {\n        this.asteroids.push(obj);\n    } else if (obj instanceof Bullet) {\n        this.bullets.push(obj);\n    } else if (obj instanceof Ship) {\n        this.ships.push(obj);\n    }\n}\n\nGame.prototype.addShip = function () {\n    const ship = new Ship({\n        pos: this.randomPosition(),\n        game: this\n    });\n    this.add(ship);\n    return ship;\n}\n\nGame.prototype.addAsteroids = function () {\n    for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {\n        this.asteroids.push(new Asteroid ({\n            pos : this.randomPosition(), \n            game: this}\n            ));\n    }\n    return this.asteroids;\n}\n\nGame.prototype.randomPosition = function () {\n    function randomInt(max) {\n        return Math.floor(Math.random() * Math.floor(max));\n    }\n    const x = randomInt(Game.DIM_X);\n    const y = randomInt(Game.DIM_Y);\n    return [x, y];\n}\n\nGame.prototype.draw = function (ctx) {\n    // clear Rect to wipe down entire space\n    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);\n    ctx.beginPath();\n    ctx.fillStyle = '#000000';\n    ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);\n    // allObject draw\n    return this.allObjects().map((obj) => obj.draw(ctx));\n}\n\n// Added delta for using requestAnimationFrame\nGame.prototype.moveObjects = function (delta) {\n    return this.allObjects().map((obj) => obj.move(delta));\n}\n\nGame.prototype.wrap = function (pos) {\n    [x, y] = pos;\n    wrapX = Util.wrap(x, Game.DIM_X);\n    wrapY = Util.wrap(y, Game.DIM_Y);\n    return [wrapX, wrapY];\n}\n\nGame.prototype.checkCollision = function () {\n    const all = this.allObjects();\n    for (let i = 0; i < all.length; i++) {\n        for (let j = 0; j < all.length; j++) {\n            if (i === j) continue;\n            const a = all[i];\n            const b = all[j];\n            if (a.isCollidedWith(b)) {\n                const collision = a.collideWith(b);\n                if (collision) return;\n            }\n        }\n    }\n}\n\nGame.prototype.step = function () {\n    this.moveObjects(); \n    this.checkCollision();\n}\n\nGame.prototype.remove = function (obj) {\n    if (obj instanceof Asteroid) {\n        let idx = this.asteroids.indexOf(obj);\n        this.asteroids.splice(idx, 1);\n    } else if (obj instanceof Bullet) {\n        let idx = this.bullets.indexOf(obj);\n        this.bullets.splice(idx, 1);\n    } else if (obj instanceof Ship) {\n        let idx = this.ship.indexOf(obj);\n        this.ships.splice(idx, 1);\n    }\n}\n\nGame.prototype.isOutOfBounds = function (pos) {\n    [x, y] = pos;\n    return (x > Game.DIM_X || x < 0 || y < 0 || y > Game.DIM_Y);\n}\n\nmodule.exports = Game;\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/game_view.js":
/*!**************************!*
  !*** ./src/game_view.js ***!
  \**************************/
/***/ ((module) => {

eval("function GameView (game, ctx) {\n    this.game = game;\n    this.ctx = ctx;\n    this.ship = this.game.addShip();\n}\n\nGameView.MOVES = {\n    w: [0, -1],\n    s: [0, 1],\n    a: [-1, 0],\n    d: [1, 0]\n}\n\nGameView.prototype.start = function () {\n    this.bindKeyHandlers();\n    // lasTime used to derive the delta\n    this.lastTime = 0;\n    \n    // Using requestAnimationFrame instead of setInterval\n    requestAnimationFrame(this.animate.bind(this));\n}\n\nGameView.prototype.bindKeyHandlers = function () {\n    const ship = this.ship;\n\n    Object.keys(GameView.MOVES).forEach((k) => {\n        const move = GameView.MOVES[k];\n        key(k, function () { ship.power(move); });\n    })\n\n    key('space', function () { ship.fireBullet(); });\n}\n\n// time = current call to animate\nGameView.prototype.animate = function (time) {\n    const delta = time - this.lastTime;\n\n    // Recursive: each frame calls the next\n    requestAnimationFrame(this.animate.bind(this));\n\n    // Move Objects\n    this.game.step(delta);\n    // Draw\n    this.game.draw(this.ctx);\n\n    // Update last refresh time\n    this.lastTime = time;\n}\n\nmodule.exports = GameView;\n\n//# sourceURL=webpack:///./src/game_view.js?");

/***/ }),

/***/ "./src/moving_object.js":
/*!******************************!*
  !*** ./src/moving_object.js ***!
  \******************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const Util = __webpack_require__(/*! ./util */ \"./src/util.js\");\n\nfunction MovingObject (options) {\n    this.pos = options.pos;\n    this.vel = options.vel;\n    this.game = options.game;\n    this.radius = options.radius;\n    this.color = options.color;\n}\n\nMovingObject.prototype.draw = function(ctx) {\n    // Invoke circle\n    ctx.beginPath();\n    // Draws Circle\n    ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI);\n    // Set Color\n    ctx.strokeStyle = \"#6AFC08\";\n    // Set Width\n    ctx.lineWidth = 10;\n    // Draws Line\n    ctx.stroke();\n    // Set Color\n    ctx.fillStyle = this.color;\n    // Fill Circle\n    ctx.fill();\n}\n\n// 1/60 th of a second\nconst NORMAL_FRAME_TIME_DELTA = 1000/60;\n\nMovingObject.prototype.move = function (timeDelta = 1) {\n    // timeDelta is number of ms since last move\n    // How far it should move\n    const velocityScale = timeDelta / NORMAL_FRAME_TIME_DELTA;\n    [x, y] = this.pos;\n    [dx, dy] = this.vel;\n\n    // Increment pos by vel * delta\n    this.pos = [x + dx * velocityScale, y + dy * velocityScale];\n    \n    if (this.game.isOutOfBounds(this.pos)) {\n        if (this.isWrappable) {\n            this.pos = this.game.wrap(this.pos);\n        } else {\n            this.remove();\n        }\n    }\n}\n\nMovingObject.prototype.isCollidedWith = function (otherObject) {\n    // Find distance between two point\n    const d = Util.distance(this.pos, otherObject.pos)\n    // Sum of their radii \n    return d < (this.radius + otherObject.radius);\n}\n\nMovingObject.prototype.collideWith = function (otherObject) {\n    // Empty\n    // Overwrote in Asteroid class\n}\n\n// Overwrote in Bullet class\nMovingObject.prototype.isWrappable = true;\n\nMovingObject.prototype.remove = function () {\n    this.game.remove(this);\n}\n\nmodule.exports = MovingObject;\n\n//# sourceURL=webpack:///./src/moving_object.js?");

/***/ }),

/***/ "./src/ship.js":
/*!*********************!*
  !*** ./src/ship.js ***!
  \*********************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

eval("const MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\nconst Util = __webpack_require__(/*! ./util */ \"./src/util.js\");\nconst Bullet = __webpack_require__(/*! ./bullet */ \"./src/bullet.js\");\n\nconst DEFAULTS = {\n    RADIUS: 15,\n    COLOR: \"#6AFC08\"\n};\n\nfunction Ship (options) {\n    options ||= options;\n    options.pos = options.pos;\n    options.color = DEFAULTS.COLOR;\n    options.radius = DEFAULTS.RADIUS;\n    options.vel = [0, 0];\n    options.game = options.game;\n\n    MovingObject.call(this, options);\n}\n\nUtil.inherits(Ship, MovingObject);\n\nShip.prototype.relocate = function () {\n    this.pos = this.game.randomPosition();\n    this.vel = [0, 0];\n}\n\nShip.prototype.power = function (impulse) {\n    [dx, dy] = impulse;\n    this.vel[0] += dx;\n    this.vel[1] += dy;\n}\n\nShip.prototype.fireBullet = function () {\n    // Get direction of travel\n    const shipVel = Util.normalize(this.vel);\n\n    // Not moving, cannot fire\n    if (shipVel === 0) {\n        return;\n    }\n\n    const bulletDir = Util.direction(this.vel);\n    const relVel = Util.scale(bulletDir, Bullet.SPEED);\n    const bulletVel = [\n        relVel[0] + this.vel[0], relVel[1] + this.vel[1]\n    ];\n\n    const bullet = new Bullet ({\n        pos: this.pos,\n        vel: bulletVel,\n        game: this.game\n    })\n    this.game.add(bullet);\n}\n\nmodule.exports = Ship;\n\n//# sourceURL=webpack:///./src/ship.js?");

/***/ }),

/***/ "./src/util.js":
/*!*********************!*
  !*** ./src/util.js ***!
  \*********************/
/***/ ((module) => {

eval("const Util = {\n    inherits(childClass, parentClass) {\n        childClass.prototype = Object.create(parentClass.prototype);\n        childClass.constructor = childClass;\n    },\n    \n    // Return a randomly oriented vector with the given length.\n    randomVec(length) {\n        const deg = 2 * Math.PI * Math.random();\n        return Util.scale([Math.sin(deg), Math.cos(deg)], length);\n    },\n    \n    // Scale the length of a vector by the given amount.\n    scale(vec, m) {\n        return [vec[0] * m, vec[1] * m];\n    },\n\n    wrap (coor, max) {\n        let newCoor;\n        // eg. wrap(11, 10) = 11 % 10 = 1 \n        if (coor > max) {\n            newCoor = coor % max;\n        } \n        // eg. wrap(-1, 10) = 10 - (-1 % 10) = 11\n        else if (coor < 0) {\n            newCoor = max - (coor % max);\n        } else {\n            newCoor = coor;\n        }\n        return newCoor;\n    },\n\n    // Find distance between two points\n    distance (pos1, pos2) {\n        // pow - pow(base, exponent)\n        return Math.sqrt(Math.pow((pos2[0] - pos1[0]), 2) + Math.pow((pos2[1] - pos1[1]), 2));\n    },\n    // Normalize lenght of vector to 1, maintain direction\n    direction (vector) {\n        const norm = Util.normalize(vector);\n        return Util.scale(vector, 1 / norm);\n    }, \n    // Find length of vector\n    normalize (vector) {\n        return Util.distance([0, 0], vector);\n    }\n\n}\n\nmodule.exports = Util;\n\n//# sourceURL=webpack:///./src/util.js?");

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
eval("const Game = __webpack_require__(/*! ./game */ \"./src/game.js\");\nconst GameView = __webpack_require__(/*! ./game_view */ \"./src/game_view.js\");\n\ndocument.addEventListener(\"DOMContentLoaded\", function () {\n    const canvasEl = document.getElementById(\"game-canvas\");\n    canvasEl.width = Game.DIM_X;\n    canvasEl.height = Game.DIM_Y;\n    const ctx = canvasEl.getContext(\"2d\");\n    const g = new Game ();\n    const gv = new GameView(g, ctx);\n    \n    gv.start();\n\n});\n\n//# sourceURL=webpack:///./src/index.js?");
})();

/******/ })()
;