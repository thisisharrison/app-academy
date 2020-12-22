const Coord = require('./coord');

class Apple {
    constructor (board) {
        this.board = board;
        this.placeRandom();
    }

    placeRandom () {
        let x = Math.floor(Math.random() * this.board.DIM_X);
        let y = Math.floor(Math.random() * this.board.DIM_Y);

        while (this.board.snake.isOccupying([x, y])) {
            x = Math.floor(Math.random() * this.board.DIM_X);
            y = Math.floor(Math.random() * this.board.DIM_Y);
        }

        this.position = new Coord(x, y);
        return this.position;
    }
}

module.exports = Apple;