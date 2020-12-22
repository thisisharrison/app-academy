const Asteroid = require("./asteroid");
const Util = require("./util");
const Ship = require("./ship");
const Bullet = require("./bullet");

function Game () {
    this.asteroids = [];
    this.addAsteroids();
    this.ships = [];
    this.bullets = [];
}

Game.DIM_X = 1000;
Game.DIM_Y = 600;
Game.NUM_ASTEROIDS = 10;

Game.prototype.allObjects = function () {
    a = [].concat(this.asteroids, this.ships, this.bullets);
    return a;
}

Game.prototype.add = function (obj) {
    if (obj instanceof Asteroid) {
        this.asteroids.push(obj);
    } else if (obj instanceof Bullet) {
        this.bullets.push(obj);
    } else if (obj instanceof Ship) {
        this.ships.push(obj);
    }
}

Game.prototype.addShip = function () {
    const ship = new Ship({
        pos: this.randomPosition(),
        game: this
    });
    this.add(ship);
    return ship;
}

Game.prototype.addAsteroids = function () {
    for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {
        this.asteroids.push(new Asteroid ({
            pos : this.randomPosition(), 
            game: this}
            ));
    }
    return this.asteroids;
}

Game.prototype.randomPosition = function () {
    function randomInt(max) {
        return Math.floor(Math.random() * Math.floor(max));
    }
    const x = randomInt(Game.DIM_X);
    const y = randomInt(Game.DIM_Y);
    return [x, y];
}

Game.prototype.draw = function (ctx) {
    // clear Rect to wipe down entire space
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    ctx.beginPath();
    ctx.fillStyle = '#000000';
    ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);
    // allObject draw
    return this.allObjects().map((obj) => obj.draw(ctx));
}

// Added delta for using requestAnimationFrame
Game.prototype.moveObjects = function (delta) {
    return this.allObjects().map((obj) => obj.move(delta));
}

Game.prototype.wrap = function (pos) {
    [x, y] = pos;
    wrapX = Util.wrap(x, Game.DIM_X);
    wrapY = Util.wrap(y, Game.DIM_Y);
    return [wrapX, wrapY];
}

Game.prototype.checkCollision = function () {
    const all = this.allObjects();
    for (let i = 0; i < all.length; i++) {
        for (let j = 0; j < all.length; j++) {
            if (i === j) continue;
            const a = all[i];
            const b = all[j];
            if (a.isCollidedWith(b)) {
                const collision = a.collideWith(b);
                if (collision) return;
            }
        }
    }
}

Game.prototype.step = function () {
    this.moveObjects(); 
    this.checkCollision();
}

Game.prototype.remove = function (obj) {
    if (obj instanceof Asteroid) {
        let idx = this.asteroids.indexOf(obj);
        this.asteroids.splice(idx, 1);
    } else if (obj instanceof Bullet) {
        let idx = this.bullets.indexOf(obj);
        this.bullets.splice(idx, 1);
    } else if (obj instanceof Ship) {
        let idx = this.ship.indexOf(obj);
        this.ships.splice(idx, 1);
    }
}

Game.prototype.isOutOfBounds = function (pos) {
    [x, y] = pos;
    return (x > Game.DIM_X || x < 0 || y < 0 || y > Game.DIM_Y);
}

module.exports = Game;