/*=========================================
    Section: profile page
    File: views / users / _show.html.erb
  =========================================*/

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


$(document).ready(function() {
  $(".btn_friend_request_cancel_submit").mouseenter(function() {
    $(".btn_friend_request_cancel_submit").prop("value", "Cancel Request");
  })
  $(".btn_friend_request_cancel_submit").mouseleave(function() {
    $(".btn_friend_request_cancel_submit").prop("value", "Friend Request Sent");
  })
});

// $(document).ready(function() {
//   $('.btn_friend_request_cancel_submit').on({
//     'mouseenter':function(){
//       $(".btn_friend_request_cancel_submit").prop("value", "Cancel Request");
//     },'mouseleave':function(){
//       $(".btn_friend_request_cancel_submit").prop("value", "Friend Request Sent");
//     }
//   });
// });

