const ApiUtil = require("./api_util");

class InfiniteTweets {
    constructor (el) {
        this.$el = $(el);
        this.$feed = this.$el.find('#feed');
        this.maxCreatedAt = null;

        this.$el.find('a').on('click', this.fetchTweets.bind(this));

        // For tweet compose
        this.$el.on('insert-tweet', this.addNewTweet.bind(this));
    }

    fetchTweets (event) {
        event.preventDefault();

        // Add payload with max_created_at for ruby's params
        const payload = {};
        if (this.maxCreatedAt) { 
            payload.max_created_at = this.maxCreatedAt;
        }
        ApiUtil.fetchTweets(payload).then((data) => this.insertTweets(data))
    }

    insertTweets (data) {
        this.$feed.append(data.map(
            this.tweetElement
        ));
        this.maxCreatedAt = data[data.length - 1].created_at;
        if (data.length < 20) {
            this.$el.find('a').off('click')
                .replaceWith('<b>No more tweets!</b>');
        }
    }

    tweetElement (tweet) {
        return `<li>${JSON.stringify(tweet)}</li>`
    }

    addNewTweet (event, data) {
        this.$feed.prepend(this.tweetElement(data));
        // Update ivar with newly created tweet
        this.maxCreatedAt = data.created_at;
    }
}

module.exports = InfiniteTweets;