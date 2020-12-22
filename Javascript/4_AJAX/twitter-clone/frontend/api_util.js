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