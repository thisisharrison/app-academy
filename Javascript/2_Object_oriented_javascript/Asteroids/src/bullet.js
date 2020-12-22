const MovingObject = require("./moving_object");
const Util = require("./util");

const DEFAULT = {
    RADIUS: 3,
    COLOR: "#6AFC08", 
}

Bullet.SPEED = 15;

function Bullet (options) {
    options = options || {};
    options.pos = options.pos;
    options.color = DEFAULT.COLOR;
    options.radius = DEFAULT.RADIUS;
    options.vel = options.vel;
    options.game = options.game;

    MovingObject.call(this, options);
}

Util.inherits(Bullet, MovingObject);

Bullet.prototype.isWrappable = false;
    
module.exports = Bullet;