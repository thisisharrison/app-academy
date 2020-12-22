const Snake = require('./snake');
const Apple = require('./apple');

class Board {
    constructor (dim_x, dim_y) {
        this.DIM_X = dim_x;
        this.DIM_Y = dim_y;
        
        this.snake = new Snake (this);
        this.apple = new Apple (this);
    }

    blankGrid () {
        return Array.from({ length: Board.DIM_X }, row => Array.from( {length: Board.DIM_Y }));
    }

    validCoord (coord) {
        return this.valid(coord.x, this.DIM_X) && this.valid(coord.y, this.DIM_Y)
    }

    valid (i, max) {
        return i >= 0 && i < max;
    }
}

Board.DIM_X = 15;
Board.DIM_Y = 10;



module.exports = Board;