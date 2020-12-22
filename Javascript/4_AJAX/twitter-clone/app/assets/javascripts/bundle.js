/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./frontend/api_util.js":
/*!******************************!*
  !*** ./frontend/api_util.js ***!
  \******************************/
/***/ ((module) => {

const ApiUtil = {

    followUser: id => ApiUtil.changeFollowStatus(id, 'POST'),

    unfollowUser: id => ApiUtil.changeFollowStatus(id, 'DELETE'),

    changeFollowStatus: (id, method) => {
        return $.ajax({
            url: `/users/${id}/follow`,
            dataType: 'json',
            method
        })
    },

    searchUsers: (queryVal) => (
        $.ajax({
            url: `/users/search?query=${queryVal}`,
            dataType: 'json',
            method: 'GET'
        })
    ),

    createTweet: (tweet) => (
        $.ajax({
            url: '/tweets',
            dataType: 'json',
            method: 'POST',
            data: tweet
        })
    ),

    fetchTweets: (data) => (
        $.ajax({
            url: '/feed',
            dataType: 'json',
            method: 'GET',
            data: data
        })
    )
    
}

module.exports = ApiUtil;

/***/ }),

/***/ "./frontend/follow_toggle.js":
/*!***********************************!*
  !*** ./frontend/follow_toggle.js ***!
  \***********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const ApiUtil = __webpack_require__(/*! ./api_util */ "./frontend/api_util.js");

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

/***/ }),

/***/ "./frontend/infinite_tweets.js":
/*!*************************************!*
  !*** ./frontend/infinite_tweets.js ***!
  \*************************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const ApiUtil = __webpack_require__(/*! ./api_util */ "./frontend/api_util.js");

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

/***/ }),

/***/ "./frontend/tweet_compose.js":
/*!***********************************!*
  !*** ./frontend/tweet_compose.js ***!
  \***********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const ApiUtil = __webpack_require__(/*! ./api_util */ "./frontend/api_util.js");

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

/***/ }),

/***/ "./frontend/user_search.js":
/*!*********************************!*
  !*** ./frontend/user_search.js ***!
  \*********************************/
/***/ ((module, __unused_webpack_exports, __webpack_require__) => {

const ApiUtil = __webpack_require__(/*! ./api_util */ "./frontend/api_util.js");
const FollowToggle = __webpack_require__(/*! ./follow_toggle */ "./frontend/follow_toggle.js");

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

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		if(__webpack_module_cache__[moduleId]) {
/******/ 			return __webpack_module_cache__[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
(() => {
/*!*****************************!*
  !*** ./frontend/twitter.js ***!
  \*****************************/
const FollowToggle = __webpack_require__(/*! ./follow_toggle */ "./frontend/follow_toggle.js");
const InfiniteTweets = __webpack_require__(/*! ./infinite_tweets */ "./frontend/infinite_tweets.js");
const TweetCompose = __webpack_require__(/*! ./tweet_compose */ "./frontend/tweet_compose.js");
const UserSearch = __webpack_require__(/*! ./user_search */ "./frontend/user_search.js");

$(() => {
    const $toggles = $('button.follow-toggle');
    $toggles.each((i, el) => {
        new FollowToggle (el);
    });

    const $userSearch = $('nav.user-search');
    $userSearch.each((i, el) => {
        new UserSearch (el);
    })

    const $tweetCompose = $('form.tweet-compose');
    new TweetCompose ($tweetCompose);

    const $infiniteTweets = $('.infinite-tweets');
    new InfiniteTweets($infiniteTweets);
});
})();

/******/ })()
;
//# sourceMappingURL=bundle.js.map