import React from 'react';
import Tile from './tile';

class Board extends React.Component {
    constructor (props) {
        super(props);
    }
    
    render() {
        const board = this.props.board.grid.map((row, index) => {
            const newRow = row.map((tile, j) => {
                return (<Tile key={`tile-${j}`}
                    tile={tile}
                    updateGame={this.props.updateGame} />)
            });
            return (
                <div key={`row-${index}`}>
                    {newRow}
                </div>
            );
        });
        return (
            <div className="board">{board}</div>
        );
    }
}

export default Board;