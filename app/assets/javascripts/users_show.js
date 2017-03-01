/*=========================================
    Section: profile page
    File: views / users / _show.html.erb
  =========================================*/

// display of section when header is clicked
$(document).ready(function() {
  $('.evts_feed').click(function() {
    $(".evts_feed_content").show();
    $(".evts_upcoming_content").hide();
    $(".evts_past_content").hide();
  });

  $('.evts_upcoming').click(function() {
    $(".evts_upcoming_content").show();
    $(".evts_feed_content").hide();
    $(".evts_past_content").hide();
  });

  $('.evts_past').click(function() {
    $(".evts_past_content").show();
    $(".evts_feed_content").hide();
    $(".evts_upcoming_content").hide();
  });
});


//change of text when hovered and clicked
$(document).ready(function() {
  $(".btn_friend_request_cancel_submit").mouseenter(function() {
    $(".btn_friend_request_cancel_submit").prop("value", "Cancel Request");
  })
  $(".btn_friend_request_cancel_submit").mouseleave(function() {
    $(".btn_friend_request_cancel_submit").prop("value", "Request Sent");
  })
});

// $(document).ready(function() {
//   $('.btn_friend_request_cancel_submit').on({
//     'mouseenter':function(){
//       $(".btn_friend_request_cancel_submit").prop("value", "Cancel Request");
//     },'mouseleave':function(){
//       $(".btn_friend_request_cancel_submit").prop("value", "Request Sent");
//     }
//   });
// });

// display of comment box
$(document).ready(function() {
  $(".display_commentbox_btn").click(function() {
    $(".comment_form_container").slideToggle();
    $(".display_commentbox_btn").hide();
  });
});







