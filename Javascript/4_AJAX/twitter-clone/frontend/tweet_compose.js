const ApiUtil = require("./api_util");

class TweetCompose {
    constructor (el) {
        this.$el = $(el);

        this.$input = this.$el.find('textarea[name=tweet\\[content\\]]');
        this.$input.on('input', this.handleInput.bind(this));
        
        this.$mentionDiv = this.$el.find('.mention-users');
        this.$el.find('.add-mention-user').on('click', this.addMentionUser.bind(this));
        // event delgation as remove-mention-user is not loaded at the beginning
        this.$mentionDiv.on('click', '.remove-mentioned-user', 
            (e) => {this.removeMentionUser(e)}
        );

        this.$el.on('submit', this.submit.bind(this));
    }

    submit (event) {
        event.preventDefault();
        const data = this.$el.serializeJSON();
        this.$el.find(':input').prop('disabled', true);
        ApiUtil.createTweet(data).then((resp) => this.handleSuccess(resp));
        
    }

    clearInput () {
        this.$input.val("");
        this.$el.find(':input').prop('disabled', false);
        this.$el.find('.chars-left').empty();
        this.$mentionDiv.empty()
    }

    handleSuccess (data) {
        // Select ul of tweets. ID of tweet is in form data. Better than hardcoding ul ID.
        const $ul = $(this.$el.data('tweets-ul'));
        // const tweet = JSON.stringify(data);
        // const $li = $('<li>');
        // $li.text(tweet);
        // $ul.append($li);
        
        // Using InfiniteTweet#addNewTweet
        $ul.trigger('insert-tweet', data);
        this.clearInput();
    }

    handleInput (data) {
        const tweetLength = this.$input.val().length;
        const $charsLeft = this.$el.find('.chars-left');
        $charsLeft.text(`${140 - tweetLength} characters left.`)
    }

    addMentionUser (event) {
        event.preventDefault();
        this.newUserSelect();
    }

    newUserSelect () {
        const options = window.users.map(user =>
            `<option value='${user.id}'>${user.username}</option>`).join('');
        // wrapped in div so removeMentionUser does not remove all mentions
        const select = `
            <div>
                <select name="tweet[mentioned_user_ids][]">
                    ${options}
                </select>

                <a href="#" class="remove-mentioned-user">Remove Mention</a>
            </div>
        `;
        this.$mentionDiv.append(select);
    }

    removeMentionUser (event) {
        event.preventDefault();
        // currentTarget = anchor tag, parent includes the select of this mention
        const $parent = $(event.currentTarget).parent()
        $parent.remove();
    }
}

module.exports = TweetCompose;