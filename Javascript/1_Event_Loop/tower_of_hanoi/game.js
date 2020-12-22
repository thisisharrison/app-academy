class Game {
    
    constructor (level) {
        this.towers = this.createTowers(level);
    }

    createTowers (level) {
        const length = parseInt(level)
        this.towers = Array.from({length: length}, tower => Array.from(1))
        for (let i = length; i > 0; i--) {
            this.towers[0].push(i);
        }
        return this.towers
    }

    promptMove (reader, callback) {
        this.print();
        reader.question('Move from? > ', (startTowerIdx) => {
            const start = parseInt(startTowerIdx);
            reader.question('Move to? > ', (endTowerIdx) => {
                const end = parseInt(endTowerIdx);
                callback(start, end);
            });
        });
    }

    isValidMove (startTowerIdx, endTowerIdx) {
        const startTower = this.towers[startTowerIdx]
        const endTower = this.towers[endTowerIdx]

        // moving from non-existing stack
        if (!!startTower && !!endTower) {
            if (startTower.length === 0) {
                return false;
            }
            // moving to non-empty stack
            else if (endTower.length === 0) {
                return true;
            }
            // moving a smaller disk to larger disk
            else {
                const startDisk = startTower[startTower.length - 1]
                // if endTower length is 0, set endDisk to 0
                const endDisk = endTower[endTower.length - 1]
                return startDisk < endDisk;
            }
        } 
        return false;
    }

    move (startTowerIdx, endTowerIdx) {
        if (!this.isValidMove(startTowerIdx, endTowerIdx)) {
            // throw new Error('Invalid Move')
            console.log('Invalid Move');
            return false;
        }
        
        const startTower = this.towers[startTowerIdx];
        const endTower = this.towers[endTowerIdx];

        const disk = startTower.pop();
        endTower.push(disk);
        return true;

    }

    isWon () {
        const start = this.towers[0]
        const others = this.towers.slice(1)
        const won = (tower) => tower.length === 3;
        if (start.length > 0) {
            return false;
        } else {
            return others.some(won);
        }
    }

    print () {
        console.log(JSON.stringify(this.towers));
    }
    
    run (reader, completionCallback) {
        this.promptMove(reader, (start, end) => {
            // Make move
            this.move(start, end)
            
            // Check if won
            if (this.isWon()) {
                console.log('You Won!');
                completionCallback();
            } else {
                this.run(reader, completionCallback);
            }
        })
    }

}

module.exports = Game;