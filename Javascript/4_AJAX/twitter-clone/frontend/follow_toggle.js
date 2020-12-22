const ApiUtil = require("./api_util");

class FollowToggle {
    constructor (el, options) {
        this.$el = $(el);
        
        this.userId = this.$el.data('user-id') || options.userId;
        this.followState = this.$el.data('initial-follow-state') || options.followState;

        this.render();
        this.$el.on('click', this.handleClick.bind(this));
    }

    render () {
        switch (this.followState) {
            case 'followed':
                this.$el.html('Unfollow!');
                this.$el.prop("disabled", false);
                break;
            case 'unfollowed':
                this.$el.html('Follow!');
                this.$el.prop("disabled", false);
                break;
            case 'following':
                this.$el.html('Following...');
                this.$el.prop("disabled", true);
                break;
            case 'unfollowing':
                this.$el.html('Unfollowing...');
                this.$el.prop("disabled", true);
                break;
        }   
    }

    handleClick (event) {
        event.preventDefault();
        
        const toggle = this;

        if (this.followState === 'followed') {
            // Renders disabled toggle
            this.followState = 'unfollowing';
            this.render();
            
            // Returns ajax request, use promise when fulfilled
            ApiUtil.unfollowUser(this.userId).then(() => {
                toggle.followState = 'unfollowed';
                toggle.render();
            });

        } else if (this.followState === 'unfollowed') {
            this.followState = 'following';
            this.render();
            
            ApiUtil.followUser(this.userId).then(() => {
                toggle.followState = 'followed';
                toggle.render();
            })
        }
    }
}

module.exports = FollowToggle;