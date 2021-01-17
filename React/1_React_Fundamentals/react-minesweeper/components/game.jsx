import React from 'react';
import * as Minesweeper from '../minesweeper';
import Board from './board';

class Game extends React.Component {
    constructor(props) {
        super(props);
        const board = new Minesweeper.Board (9, 10);
        this.state = {
            board: board
        }

        this.updateGame = this.updateGame.bind(this);
        this.restart = this.restart.bind(this);
    }

    updateGame (tile, flagged) {
        if (flagged) {
            tile.toggleFlag();
        } else {
            tile.explore();
        }
        this.setState({ board: this.state.board });
    }

    restart (e) {
        e.preventDefault;
        const board = new Minesweeper.Board(9, 10);
        this.setState({ board: board });
    }
    
    render () {
        let modal;
        const won = this.state.board.won();
        const lost = this.state.board.lost();
        if (won || lost) {
            const text = won ? 'You won!' : 'You lost!'
            modal = 
                <div className='modal-screen'>
                    <div className='modal-content'>
                        <p>{text}</p>
                        <button onClick={this.restart}>Play Again?</button>
                    </div>
                </div>
        }
        return (
            <div className="game">
                <h1>Minesweeper</h1>
                {modal}
                <Board
                    board={this.state.board}
                    updateGame={this.updateGame}
                />
            </div>
        )
    }
}

export default Game;