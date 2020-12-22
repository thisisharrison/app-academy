const Coord = require('./coord');
const Board = require('./board');

class Snake {
    constructor (board) {
        this.dir = 'N';
        this.wrappable = false;
        this.board = board;
        
        const center = new Coord (Math.floor(board.DIM_X / 2), Math.floor(board.DIM_Y / 2));
        this.segments = [center];
        this.growth = 0;
    }

    head () {
        return this.segments.slice(-1)[0];
    }

    body () {
        return this.segments.slice(0, -1);
    }

    move () {
        // move forward 
        let new_seg = this.head().plus(Snake.DIFF[this.dir]);

        if (this.wrappable) {
            // wrap if exceed boarder
            this.segments.push(new_seg.wrap(this.board.DIM_X, this.board.DIM_Y));
        } else {
            this.segments.push(new_seg);
        }
        
        this.eatsApple();

        // Each interval grow 1 block
        if (this.growth > 0) {
            this.growth -= 1;
        } 
        else {
            this.segments.shift();
        }

        if (this.isOver()) {
            // this.segments = [];
            return false;
        } else {
            return true;
        }
    }

    turn (dir) {
        // Should not turn to itself
        if (Snake.DIFF[this.dir].isOpposite(Snake.DIFF[dir])) {
            return;
        } else {
            this.dir = dir;
        }
    }

    isOver () {
        if (this.hitWall()) {
            return true
        }
        return this.hitSelf();
    }

    // Something's not right
    hitWall () {
        if (!this.board.validCoord(this.head())) {
            return true;
        };
    }

    hitSelf () {
        return this.body().some(coord => coord.equals(this.head()));
    }

    // To not place apple on snake body
    isOccupying (coord) {
        let x, y;
        [x, y] = coord;
        let pos = new Coord(x, y);
        return this.segments.some(c => c.equals(pos));
    }

    eatsApple () {
        if (this.head().equals(this.board.apple.position)) {
            this.growth += 3; 
            this.board.apple.placeRandom();
            return true;
        }
    }
}

Snake.DIFF = {
    'N': new Coord (-1, 0),
    'E': new Coord (0, 1),
    'W': new Coord (0, -1),
    'S': new Coord (1, 0)
}

module.exports = Snake;