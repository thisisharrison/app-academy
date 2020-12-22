class HanoiView {
    constructor (game, $el) {
        this.game = game;
        this.$el = $el;
        this.fromTower = null;
        this.screenSize = $(window).width();

        this.setUpTowers();
        this.bindClick();
        this.render();
    }

    setUpTowers () {
        // Reset
        this.$el.empty()

        const length = this.game.towers.length;
        for (let tower = 0; tower < length; tower ++) {
            const $ul = $('<ul>');
            for (let disc = 0; disc < length; disc ++) {
                const $li = $('<li>');
                $ul.append($li);
            }
            this.$el.append($ul);
        }
    }

    bindClick () {
        this.$el.on('click', 'ul', event => {
            this.clickTower($(event.currentTarget));
        });
    }

    render () {
        const $towers = this.$el.find('ul');
        // Reset
        $towers.removeClass();

        $towers.each((i, tower) => {
            const $disks = $(tower).children();
            // Reset
            $disks.width("")

            $(tower).toggleClass( () => {
                if (this.fromTower === i) {
                    return 'selected';
                }
            })

            $disks.each((j, disk) => {
                // Negative Index on jQuery object
                let diskIdx = -1 * (j + 1);
                
                // Dynamic sizing
                const size = this.game.towers[i][j];
                $disks.eq(diskIdx).width(size * 60);
            })
        })
    }

    clickTower($tower) {
        const towerIdx = $tower.index();

        if (this.fromTower === null) {
            this.fromTower = towerIdx;
        } else {
            if (!this.game.move(this.fromTower, towerIdx)) {
                alert('Invalid Move! Try Again');
            }
            this.fromTower = null;
        }

        this.render();

        if (this.game.isWon()) {
            // Reset
            this.$el.off('click');
            this.$el.addClass('game-over');
            
            const $figcaption = $('<figcaption>').html('Well Done!');
            $figcaption.insertAfter(this.$el);

            const $button = $('<button>').html('Play Again');
            $button.insertAfter($figcaption);

            $button.on('click', event => location.reload(true));

        }

    }
}

module.exports = HanoiView;