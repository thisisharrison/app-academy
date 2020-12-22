class Coord {
    constructor (x, y) {
        this.x = x;
        this.y = y;
    }
    
    plus (p2) {
        return new Coord (this.x + p2.x, this.y + p2.y);
    }

    equals (p2) {
        return this.x === p2.x && this.y === p2.y;
    }

    isOpposite (p2) {
        return this.x === -1 * p2.x && this.y === -1 * p2.y;
    }

    wrap (max_x, max_y) {
        this.x = this.wrapping(this.x, max_x);
        this.y = this.wrapping(this.y, max_x);
    }

    wrapping (og, max) {
        let _new;
        if (og > max) {
            _new = max % og;
        }
        else if (og < 0) {
            _new = max - (og % max)
        } else {
            _new = og;
        }
        return _new;
    }
}

module.exports = Coord;