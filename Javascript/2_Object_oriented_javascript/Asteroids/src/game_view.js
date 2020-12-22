function GameView (game, ctx) {
    this.game = game;
    this.ctx = ctx;
    this.ship = this.game.addShip();
}

GameView.MOVES = {
    w: [0, -1],
    s: [0, 1],
    a: [-1, 0],
    d: [1, 0]
}

GameView.prototype.start = function () {
    this.bindKeyHandlers();
    // lasTime used to derive the delta
    this.lastTime = 0;
    
    // Using requestAnimationFrame instead of setInterval
    requestAnimationFrame(this.animate.bind(this));
}

GameView.prototype.bindKeyHandlers = function () {
    const ship = this.ship;

    Object.keys(GameView.MOVES).forEach((k) => {
        const move = GameView.MOVES[k];
        key(k, function () { ship.power(move); });
    })

    key('space', function () { ship.fireBullet(); });
}

// time = current call to animate
GameView.prototype.animate = function (time) {
    const delta = time - this.lastTime;

    // Recursive: each frame calls the next
    requestAnimationFrame(this.animate.bind(this));

    // Move Objects
    this.game.step(delta);
    // Draw
    this.game.draw(this.ctx);

    // Update last refresh time
    this.lastTime = time;
}

module.exports = GameView;