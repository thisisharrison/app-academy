const Game = require('./game');
const GameView = require('./game_view');

document.addEventListener("DOMContentLoaded", function () {
    const canvasEl = document.getElementById("game-canvas");
    canvasEl.width = Game.DIM_X;
    canvasEl.height = Game.DIM_Y;
    const ctx = canvasEl.getContext("2d");
    const g = new Game ();
    const gv = new GameView(g, ctx);
    
    gv.start();

});