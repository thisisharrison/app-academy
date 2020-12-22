const Util = require("./util");
const MovingObject = require("./moving_object");
const Ship = require("./ship");
const Bullet = require("./bullet");

const DEFAULTS = {
    RADIUS: 25,
    COLOR: "#000000"
};

function Asteroid (options) {
    options = options || {}
    options.pos = options.pos;
    options.color = DEFAULTS.COLOR;
    options.radius = DEFAULTS.RADIUS;
    options.vel = Util.randomVec(10);
    options.game = options.game;
    
    // Call to access code inside MovingObject, like Ruby's super
    MovingObject.call(this, options);
}
// Sets up prototype chain inheritance
Util.inherits(Asteroid, MovingObject);

Asteroid.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Ship) {
        otherObject.relocate ();
        return true;
    } else if (otherObject instanceof Bullet) {
        this.remove();
        otherObject.remove();
        return true;
    }
    return false;
}

module.exports = Asteroid;