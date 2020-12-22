const Board = require('./board');

class View {
    constructor ($el) {
        this.$el = $el;
        
        // Flexible game size depend on window
        let x, y;
        [x, y] = this.screenSize();
        this.DIM_X = x;
        this.DIM_Y = y;

        this.board = new Board (x, y);
        // Paints Board 
        this.setUpGrid();
        // Control snake moves
        this.bindKeys();
        // Renders every half second
        this.intervalId = window.setInterval(
            this.step.bind(this),
            500
        )
    }

    screenSize () {
        const dim_x = Math.floor($(window).width() * 0.4 / 20);
        const dim_y = Math.floor($(window).height() * 0.8 / 20);
        return [dim_x, dim_y];
    }

    bindKeys () {
        $(window).on('keydown', this.handleKeyEvent.bind(this));
    }

    handleKeyEvent (event) {
        if (View.KEYS[event.keyCode]) {
            this.board.snake.turn(View.KEYS[event.keyCode])
        }
    }

    step () {
        if (this.board.snake.move()) {
            this.render();
        } else {
            window.clearInterval(this.intervalId);
            this.isOver();
        }
    }

    isOver () {
        const $figcaption = $('<figcaption>');
        $figcaption.html('Game Over');
        $figcaption.insertAfter(this.$el);
    }

    setUpGrid () {
        const grid = this.board.blankGrid();
        const $div = $('<div>').addClass('board');
        for (let row = 0; row < this.DIM_X; row++) {
            const $ul = $('<ul>');
            for (let col = 0; col < this.DIM_Y; col++) {
                const $li = $('<li>');
                $ul.append($li);
            }
            $div.append($ul);
        }
        this.$el.append($div);
        this.render();
    }
    
    render () {
        // Reset
        this.$el.find('li').removeClass();

        this.board.snake.segments.map((coord) => {
            this.updateClass(coord, 'snake');
        });

        this.updateClass(this.board.apple.position, 'apple');
    }

    updateClass (coord, type) {
        // first row or tenth row plus index in that row
        const $row = this.$el.find('ul').eq(coord.x);
        const $col = $row.find('li').eq(coord.y);

        $col.addClass(type);
    }
}

View.KEYS = {
    38: 'N',
    40: 'S',
    37: 'W',
    39: 'E'
}

module.exports = View;