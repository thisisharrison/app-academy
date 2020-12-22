const Util = require("./util");

function MovingObject (options) {
    this.pos = options.pos;
    this.vel = options.vel;
    this.game = options.game;
    this.radius = options.radius;
    this.color = options.color;
}

MovingObject.prototype.draw = function(ctx) {
    // Invoke circle
    ctx.beginPath();
    // Draws Circle
    ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI);
    // Set Color
    ctx.strokeStyle = "#6AFC08";
    // Set Width
    ctx.lineWidth = 10;
    // Draws Line
    ctx.stroke();
    // Set Color
    ctx.fillStyle = this.color;
    // Fill Circle
    ctx.fill();
}

// 1/60 th of a second
const NORMAL_FRAME_TIME_DELTA = 1000/60;

MovingObject.prototype.move = function (timeDelta = 1) {
    // timeDelta is number of ms since last move
    // How far it should move
    const velocityScale = timeDelta / NORMAL_FRAME_TIME_DELTA;
    [x, y] = this.pos;
    [dx, dy] = this.vel;

    // Increment pos by vel * delta
    this.pos = [x + dx * velocityScale, y + dy * velocityScale];
    
    if (this.game.isOutOfBounds(this.pos)) {
        if (this.isWrappable) {
            this.pos = this.game.wrap(this.pos);
        } else {
            this.remove();
        }
    }
}

MovingObject.prototype.isCollidedWith = function (otherObject) {
    // Find distance between two point
    const d = Util.distance(this.pos, otherObject.pos)
    // Sum of their radii 
    return d < (this.radius + otherObject.radius);
}

MovingObject.prototype.collideWith = function (otherObject) {
    // Empty
    // Overwrote in Asteroid class
}

// Overwrote in Bullet class
MovingObject.prototype.isWrappable = true;

MovingObject.prototype.remove = function () {
    this.game.remove(this);
}

module.exports = MovingObject;