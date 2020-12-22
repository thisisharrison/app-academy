class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents()
  }

  bindEvents() {
    this.$el.on('click', 'li', event => {
      const $square = $(event.currentTarget);
      this.makeMove($square);
    });
  }

  makeMove($square) {
    const pos = $square.data('pos');
    const currentPlayer = this.game.currentPlayer;
    
    try {
      this.game.playMove(pos);
    } catch (e) {
      alert("This " + e.msg.toLowerCase());
      return;
    }
    
    $square.addClass(currentPlayer);

    if (this.game.isOver()) {
      // remove handlers
      this.$el.off('click');
      // this.$el.addClass('game-over');

      const winner = this.game.winner();
      const $figcaption = $('<figcaption>');
      
      if (winner) {
        $(`.${winner}`).css('background-color', 'green');
        $figcaption.html(`Player ${winner} Wins!!!`);
      } else {
        $('li').addClass('draw');
        $figcaption.html('It\'s a draw!');
      }

      this.$el.append($figcaption);
      this.completionCB();
    }
  }

  setupBoard() {
    const $ul = $('<ul>')

    for (let row = 0; row < 3; row++) {
      for (let col = 0; col < 3; col++) {
        const $li = $('<li>');
        $li.data('pos', [row, col]);
        $ul.append($li);
      }
    }

    this.$el.append($ul);
  }

  completionCB() {
    const $div = $('<div>').addClass('play-again');
    const $button = $('<button>');
    
    $button.html('Play Again');
    $div.append($button);
    
    $div.insertAfter(this.$el);

    $button.on('click', event => {
      location.reload(true);
    })

  }
}

module.exports = View;
