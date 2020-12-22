// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  var Piece = require("./piece");
}
// DON'T TOUCH THIS CODE

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  const grid = Array.from({length: 8}, row => Array.from({length: 8}));
  grid[3][4] = new Piece('black');
  grid[4][3] = new Piece('black');
  grid[3][3] = new Piece('white');
  grid[4][4] = new Piece('white');
  return grid;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  let x = pos[0];
  let y = pos[1];
  return x <= 7 && x >= 0 && y <= 7 && y >= 0;
};

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  if (this.isValidPos(pos)) {
    return this.grid[pos[0]][pos[1]];
  } else {
    throw new Error('Not valid pos!');
  }
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  const piece = this.getPiece(pos);
  return piece && piece.color === color;
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  // double ! returns truthy and falsey association: !!null = false, !!undefined = false
  return !!this.getPiece(pos);
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns an empty array if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns empty array if it hits an empty position.
 *
 * Returns empty array if no pieces of the opposite color are found.
 */
Board.prototype._positionsToFlip = function(pos, color, dir, piecesToFlip){
  if (!piecesToFlip) {
    piecesToFlip = [];
  } else {
    // current position made it, add to array
    piecesToFlip.push(pos);
  }
  
  let dir_x = dir[0]
  let dir_y = dir[1]
  let pos_x = pos[0]
  let pos_y = pos[1]
  let new_pos = [pos_x + dir_x, pos_y + dir_y]
  // if out of bound or empty pos or not opposite color or not opponent
  if (!this.isValidPos(new_pos)) {
    return [];
  } else if (!this.isOccupied(new_pos)) {
    return [];
  } else if (this.isMine(new_pos, color)) {
    return piecesToFlip.length === 0 ? [] : piecesToFlip;
  } else {
    // pos OK, return to add to piecesToFlip array in next cycle
    return this._positionsToFlip(new_pos, color, dir, piecesToFlip);
  }
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  if (this.isOccupied(pos)) {
    return false;
  }
  for(let i = 0; i < Board.DIRS.length; i++){
    const piecesToFlip = this._positionsToFlip(pos, color, Board.DIRS[i]);
    if (piecesToFlip.length) {
      return true;
    }
  }
  return false;
};

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  if (!this.validMove(pos, color)) {
    throw new Error('Invalid move!');
  } 
  let positionsToFlip = [];
  Board.DIRS.forEach(dir => {
    positionsToFlip = positionsToFlip.concat(this._positionsToFlip(pos, color, dir));
  })
  
  positionsToFlip.forEach(pos => {
    this.getPiece(pos).flip();
  })

  this.grid[pos[0]][pos[1]] = new Piece (color);

};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  const validMoves = []
  for (let row = 0; row < this.grid.length; row++) {
    for (let col = 0; col < this.grid.length; col++) {
      if (this.validMove([row, col], color)) {
        validMoves.push([row, col]);
      }
    }
  }
  return validMoves;
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  return !!this.validMoves(color).length;
};



/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  return !(this.hasMove('black') || this.hasMove('white'));
};




/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  console.log("   |01234567")
  for (let row = 0; row < this.grid.length; row++) {
    let rowString = " " + row + " |"

    for (let col = 0; col < this.grid.length; col++) {
      let pos = [row, col]
      rowString += (this.getPiece(pos) ? this.getPiece(pos).toString() : ".")
    }

    console.log(rowString);
  }
};


// DON'T TOUCH THIS CODE
if (typeof window === 'undefined'){
  module.exports = Board;
}
// DON'T TOUCH THIS CODE