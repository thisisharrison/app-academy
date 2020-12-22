const ApiUtil = require("./api_util");
const FollowToggle = require("./follow_toggle");

class UserSearch {
    constructor (el) {
        this.$el = $(el);

        this.$input = this.$el.find('input');
        this.$ul = this.$el.find('ul');

        this.$input.on('input', this.handleInput.bind(this));
    }

    handleInput (event) {
        ApiUtil.searchUsers(this.$input.val()).then(resp => this.renderResults(resp));
    }

    renderResults (resp) {
        // Empty out previous results
        this.$ul.empty();
        resp.forEach(user => {
            const $li = $('<li>');
            $li.html(`<a href="/users/${user.id}">${user.username}</a>`);

            const $followToggle = $('<button>');
            new FollowToggle ($followToggle, {
                userId: user.id, 
                followState: user.followed ? 'followed' : 'unfollowed'
            });

            $li.append($followToggle);
            this.$ul.append($li);
        });
    }
}

module.exports = UserSearch;