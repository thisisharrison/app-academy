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

/***/ "./src/game.js":
/*!*********************!*
  !*** ./src/game.js ***!
  \*********************/
/***/ ((module) => {

eval("class Game {\n  constructor() {\n    this.towers = [[3, 2, 1], [], []];\n  }\n\n  isValidMove(startTowerIdx, endTowerIdx) {\n      const startTower = this.towers[startTowerIdx];\n      const endTower = this.towers[endTowerIdx];\n\n      if (startTower.length === 0) {\n        return false;\n      } else if (endTower.length == 0) {\n        return true;\n      } else {\n        const topStartDisc = startTower[startTower.length - 1];\n        const topEndDisc = endTower[endTower.length - 1];\n        return topStartDisc < topEndDisc;\n      }\n  }\n\n  isWon() {\n      // move all the discs to the last or second tower\n      return (this.towers[2].length == 3) || (this.towers[1].length == 3);\n  }\n\n  move(startTowerIdx, endTowerIdx) {\n      if (this.isValidMove(startTowerIdx, endTowerIdx)) {\n        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());\n        return true;\n      } else {\n        return false;\n      }\n  }\n\n  print() {\n      console.log(JSON.stringify(this.towers));\n  }\n\n  promptMove(reader, callback) {\n      this.print();\n      reader.question(\"Enter a starting tower: \", start => {\n        const startTowerIdx = parseInt(start);\n        reader.question(\"Enter an ending tower: \", end => {\n          const endTowerIdx = parseInt(end);\n          callback(startTowerIdx, endTowerIdx);\n        });\n      });\n  }\n\n  run(reader, gameCompletionCallback) {\n      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {\n        if (!this.move(startTowerIdx, endTowerIdx)) {\n          console.log(\"Invalid move!\");\n        }\n\n        if (!this.isWon()) {\n          // Continue to play!\n          this.run(reader, gameCompletionCallback);\n        } else {\n          this.print();\n          console.log(\"You win!\");\n          gameCompletionCallback();\n        }\n      });\n  }\n}\n\nmodule.exports = Game;\n\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/hanoi-view.js":
/*!***************************!*
  !*** ./src/hanoi-view.js ***!
  \***************************/
/***/ ((module) => {

eval("class HanoiView {\n    constructor (game, $el) {\n        this.game = game;\n        this.$el = $el;\n        this.fromTower = null;\n        this.screenSize = $(window).width();\n\n        this.setUpTowers();\n        this.bindClick();\n        this.render();\n    }\n\n    setUpTowers () {\n        // Reset\n        this.$el.empty()\n\n        const length = this.game.towers.length;\n        for (let tower = 0; tower < length; tower ++) {\n            const $ul = $('<ul>');\n            for (let disc = 0; disc < length; disc ++) {\n                const $li = $('<li>');\n                $ul.append($li);\n            }\n            this.$el.append($ul);\n        }\n    }\n\n    bindClick () {\n        this.$el.on('click', 'ul', event => {\n            this.clickTower($(event.currentTarget));\n        });\n    }\n\n    render () {\n        const $towers = this.$el.find('ul');\n        // Reset\n        $towers.removeClass();\n\n        $towers.each((i, tower) => {\n            const $disks = $(tower).children();\n            // Reset\n            $disks.width(\"\")\n\n            $(tower).toggleClass( () => {\n                if (this.fromTower === i) {\n                    return 'selected';\n                }\n            })\n\n            $disks.each((j, disk) => {\n                // Negative Index on jQuery object\n                let diskIdx = -1 * (j + 1);\n                \n                // Dynamic sizing\n                const size = this.game.towers[i][j];\n                $disks.eq(diskIdx).width(size * 60);\n            })\n        })\n    }\n\n    clickTower($tower) {\n        const towerIdx = $tower.index();\n\n        if (this.fromTower === null) {\n            this.fromTower = towerIdx;\n        } else {\n            if (!this.game.move(this.fromTower, towerIdx)) {\n                alert('Invalid Move! Try Again');\n            }\n            this.fromTower = null;\n        }\n\n        this.render();\n\n        if (this.game.isWon()) {\n            // Reset\n            this.$el.off('click');\n            this.$el.addClass('game-over');\n            \n            const $figcaption = $('<figcaption>').html('Well Done!');\n            $figcaption.insertAfter(this.$el);\n\n            const $button = $('<button>').html('Play Again');\n            $button.insertAfter($figcaption);\n\n            $button.on('click', event => location.reload(true));\n\n        }\n\n    }\n}\n\nmodule.exports = HanoiView;\n\n//# sourceURL=webpack:///./src/hanoi-view.js?");

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
eval("const HanoiGame = __webpack_require__(/*! ./game */ \"./src/game.js\")\nconst HanoiView = __webpack_require__(/*! ./hanoi-view */ \"./src/hanoi-view.js\")\n\n$(() => {\n  const rootEl = $('.hanoi');\n  const game = new HanoiGame();\n  new HanoiView(game, rootEl);\n\n});\n\n\n//# sourceURL=webpack:///./src/index.js?");
})();

/******/ })()
;