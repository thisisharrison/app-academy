/* jshint esversion: 6 */

function View($el) {
  this.$el = $el;
  this.setupEasel();
}

window._randomColorString = function(){
  return '#' + Math.random().toString(16).substr(-6);
};

View.prototype.exercise0 = function () {
  //Challenge: (example) remove the 'square' class from every li
  
  $('li').removeClass("square");
};

View.prototype.exercise1 = function () {
  //Challenge: Give every square the class 'orange'
  
  $('li').addClass('orange');
};

View.prototype.exercise2 = function () {
  //Challenge: Remove every square
  
  $('.square').remove();
};

View.prototype.exercise3 = function () {
  //Challenge: Add an <h1> with the text 'i love jquery' under the grid.
  
  const h1 = $('<h1>').text('i love jquery');
  $('#easel').append(h1);
};

View.prototype.exercise4 = function () {
  //Challenge: Write your first name in every other square.
  
  // CSS
  // $('.square:nth-child(even)').text('HL');
  // The index of each child to match, starting with 1, the string even or odd.

  // Iteration 1
  // $('li').each((index, el) => {
  //   if (!(index % 2 === 0)) {
  //     $(el).text('HL');
  //   }
  // });

  // Iteration 2
  $('li:odd').text('HL');
};

View.prototype.exercise5 = function () {
  //Challenge: Alert the row and column of the square, when the square is clicked.

  $('ul').on('click', 'li', event => {
    let pos = $(event.currentTarget).attr('data-pos');
    alert(pos);
  })
};

View.prototype.exercise6 = function () {
  //Challenge: Give every square a random color!

  $('.square').each((idx, el) => {
    $(el).css('background-color', window._randomColorString());
  });
};

View.prototype.exercise7 = function(){
  //Challenge: When your mouse goes over a square, console log its color.
  
  $('button').get(7).click();

  $('#easel').on('mouseenter', '.square', event => {
    let color = $(event.currentTarget).css('background-color');
    console.log(color);
  })

};



View.prototype.setupEasel = function() {
  const $addRowButton = $('<button>').html('Add a row');
  this.$el.append($addRowButton);
  $addRowButton.on("click", this.addRow.bind(this));

  for(let j = 0; j <= 7; j++){
    const $button = $("<button>").html("Exercise " + j);
    $button.on("click", this["exercise" + j]);
    this.$el.append($button);
  }

  for(let i = 0; i < 20; i ++) {
    this.addRow();
  }
};

View.prototype.addRow = function() {
  const rowIdx = this.$el.find(".row").length;
  const $row = $("<ul>").addClass("row").addClass("group");
  for(let colIdx = 0; colIdx < 20; colIdx++) {
    const $square = $("<li>").addClass("square").attr("data-pos", [rowIdx, colIdx]);
    $square.on("mouseenter", (e) => {
      const $square = $(e.currentTarget);
      $square.css("background-color", window._randomColorString());
    });
    $row.append($square);
  }
  this.$el.append($row);
};

module.exports = View;
