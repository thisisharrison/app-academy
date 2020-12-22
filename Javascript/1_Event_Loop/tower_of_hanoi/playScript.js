const Game = require('./game.js');
const readline = require('readline');
const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
})

function completionCallback(){
    reader.question('Play again? (yes or no) > ', (ans) => {
        if (ans === 'yes') {
            startGame();
        } else {
            reader.close();
        }
    })
}

function startGame() {
    reader.question('Select difficulty (eg. 3) > ', (ans) => {
        let g = new Game(ans);
        g.run(reader, completionCallback);
    })
}

startGame();