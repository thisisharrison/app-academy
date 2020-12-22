class Board {
    constructor (length = 3) {
        this.grid = this.makeGrid(length);
    }

    isValidPos (pos) {
        let x, y;
        [x, y] = pos
        
        return (x >= 0) && (y >= 0) && 
        (x < this.grid.length) && (y < this.grid.length);
    }

    getPos (pos) {
        let x, y;
        [x, y] = pos
        return this.grid[x][y];
    }

    validMark (el) {
        if (!!el) {
            return Board.marks.includes(el);
        }
        return false;
    }

    straightWin (grid) {
        const length = this.grid.length;

        for (let row = 0; row < length; row++) {
            // every element is the same as first element and first el is valid
            if (grid[row].every(el => el === grid[row][0] && this.validMark(el))) {
                this.winner = grid[row][0];
                return true;
            }
        }
        return false;
    }

    transpose () {
        const length = this.grid.length;
        const transpose = this.makeGrid(length);

        for (let row = 0; row < length; row++) {
            for (let col = 0; col < length; col++) {
                transpose[col][row] = this.grid[row][col];
            }
        }
        return transpose;
    }

    rowWin () {
        return this.straightWin(this.grid);
    }

    colWin () {
        return this.straightWin(this.transpose());
    }

    diagonalWin () {
        const length = this.grid.length;
        const left = this.grid[0][0];
        const right = this.grid[0][length - 1]

        const leftDiag = []
        const rightDiag = []
        for (let i = 0; i < length; i++) {
            leftDiag.push(this.grid[i][i]);
            rightDiag.push(this.grid[length - 1 - i][i]);
        }

        // every element is the same as first element and first el is valid
        if (leftDiag.every(el => el === left && this.validMark(el))) {
            this.winner = left;
            return true;
        } else if (rightDiag.every(el => el === right && this.validMark(el))) {
            this.winner = right;
            return true;
        } else {
            return false;
        }
    }


    won () {
        // horizontal win
        return this.rowWin() ||
        // vertical win
        this.colWin() ||
        // diagonal win
        this.diagonalWin()    
    }

    isOver () {
        if (this.won()) {
            return true;
        } else {
            // if null exists, still playing, return false
            // if null doesn't exist but not won, return true = draw
            const flatGrid = this.grid.reduce((acc, el) => acc.concat(el), [])
            return !(flatGrid.find(el => this.validMark(el)));
        }
    }

    empty (pos) {
        // undefined returns turn, marked returns false
        return this.isValidPos(pos) && !this.getPos(pos);
    }

    place_mark (pos, mark) {
        if (this.isValidPos(pos) && this.empty(pos)) {
            let x, y;
            [x, y] = pos
            this.grid[x][y] = mark;
            return this.getPos(pos);
        } else {
            console.log('Invalid Pos')
            return false;
        }
    }

    makeGrid (length) {
        return Array.from({ length: length }, row => Array.from({ length: length }));
    }

    print() {
        const length = this.grid.length;
        let header = "  | "
        for (let col = 0; col < length; col++) {
            header += col + " "
        }
        console.log(header)
        for (let row = 0; row < length; row++) {
            console.log(row + " | " + this.grid[row].map(el => this.toString(el)).join(''))
        }
    }

    toString (el) {
        return el === undefined ? "  " : (String(el) + ' ');
    }
}

Board.marks = ['x', 'o']

module.exports = Board;