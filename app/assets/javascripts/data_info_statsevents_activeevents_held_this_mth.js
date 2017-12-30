/*=========================================
    Userrs admin events
    File: views / shared / _data_info_statsevents_activeevents_held_this_mth.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsevents_active_paid_heldThisMonth').click(function() {
    $("#status_statsevents_active_paid_heldThisMonth_content").show();
    $("#status_statsevents_active_free_heldThisMonth_content").hide();
  });

  $('#status_statsevents_active_free_heldThisMonth').click(function() {
    $("#status_statsevents_active_free_heldThisMonth_content").show();
    $("#status_statsevents_active_paid_heldThisMonth_content").hide();
  });
});