/* ********************************************************************************************
   | Handle Submitting Posts - called by $('#post-button').click(submitPost)
   ********************************************************************************************
   */
function response(data,status) {
    if (status === 'success') {
        location.reload();
    }
    else {
        alert('failed to submit post' + status);
    }
}

function submitPost(event) {
    let data = $("#post-text").text();
    let json_data = { 'postContent' : data } ;
    let url_path = post_submit_url;



    $.post(url_path,
           json_data,
           response);
}


/* ********************************************************************************************
   | Handle Liking Posts - called by $('.like-button').click(submitLike)
   ********************************************************************************************
   */

function likePostResponse(data,status) {
    if (status === 'success') {
        // reload page to display new Post
        location.reload();
    }
    else {
        alert('failed to like post' + status);
    }
}

function submitLike(event) {
    let json_data = {'postID': event.target.id};



    let url_path = like_post_url;
    




    $.post(url_path,
           json_data,
           likePostResponse);
}










/* ********************************************************************************************
   | Handle Requesting More Posts - called by $('#more-button').click(submitMore)
   ********************************************************************************************
   */
function moreResponse(data,status) {
    if (status == 'success') {
        // reload page to display new Post
        location.reload();
    }
    else {
        alert('failed to request more posts' + status);
    }
}

function submitMore(event) {
    // submit empty data
    let json_data = { };
    // globally defined in messages.djhtml using i{% url 'social:more_post_view' %}
    let url_path = more_post_url;

    // AJAX post
    $.post(url_path,
           json_data,
           moreResponse);
}

/* ********************************************************************************************
   | Document Ready (Only Execute After Document Has Been Loaded)
   ********************************************************************************************
   */
$(document).ready(function() {
    // handle post submission
    $('#post-button').click(submitPost);
    // handle likes
    $('.like-button').click(submitLike);
    // handle more posts
    $('#more-button').click(submitMore);
});
