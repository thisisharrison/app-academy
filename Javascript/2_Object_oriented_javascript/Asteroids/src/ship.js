const MovingObject = require("./moving_object");
const Util = require("./util");
const Bullet = require("./bullet");

const DEFAULTS = {
    RADIUS: 15,
    COLOR: "#6AFC08"
};

function Ship (options) {
    options ||= options;
    options.pos = options.pos;
    options.color = DEFAULTS.COLOR;
    options.radius = DEFAULTS.RADIUS;
    options.vel = [0, 0];
    options.game = options.game;

    MovingObject.call(this, options);
}

Util.inherits(Ship, MovingObject);

Ship.prototype.relocate = function () {
    this.pos = this.game.randomPosition();
    this.vel = [0, 0];
}

Ship.prototype.power = function (impulse) {
    [dx, dy] = impulse;
    this.vel[0] += dx;
    this.vel[1] += dy;
}

Ship.prototype.fireBullet = function () {
    // Get direction of travel
    const shipVel = Util.normalize(this.vel);

    // Not moving, cannot fire
    if (shipVel === 0) {
        return;
    }

    const bulletDir = Util.direction(this.vel);
    const relVel = Util.scale(bulletDir, Bullet.SPEED);
    const bulletVel = [
        relVel[0] + this.vel[0], relVel[1] + this.vel[1]
    ];

    const bullet = new Bullet ({
        pos: this.pos,
        vel: bulletVel,
        game: this.game
    })
    this.game.add(bullet);
}

module.exports = Ship;