const FollowToggle = require('./follow_toggle');
const InfiniteTweets = require('./infinite_tweets');
const TweetCompose = require('./tweet_compose');
const UserSearch = require('./user_search');

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