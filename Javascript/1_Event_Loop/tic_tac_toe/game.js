const Board = require('./board.js');

class Game {
    constructor (level) {
        this.board = new Board (level);
        this.currentPlayer = Board.marks[0]
    }

    isOver () {
        return this.board.isOver();
    }

    promptMove (reader, callback) {
        this.board.print()
        console.log(`Current Player > ${this.currentPlayer}`)

        reader.question('Enter row > ', (row) => {
            const x = parseInt(row);
            reader.question('Enter col > ', (col) => {
                const y = parseInt(col);
                const pos = [x, y];
                callback(pos);
            })
        })
    }

    playMove (pos) {
        const move = this.board.place_mark(pos, this.currentPlayer);
        if (move) {
            this.swapTurn();
            return true;
        } else {
            return false;
        }
    }

    swapTurn () {
        this.currentPlayer = this.currentPlayer === Board.marks[0] ? Board.marks[1] : Board.marks[0];
        return this.currentPlayer
    }

    winner () {
        return this.board.winner;
    }

    run (reader, reset) {
        // make a move
        this.promptMove (reader, pos => {
            this.playMove(pos);

            // if over
            if (this.isOver()) {
                this.board.print();
                if (this.winner()) {
                    console.log(`Player ${this.winner()} has won!`);
                } else {
                    console.log('It\'s a tie!');
                }
                reset()
            } else {
                this.run(reader, reset);
            }
        })
    }
}

module.exports = Game;