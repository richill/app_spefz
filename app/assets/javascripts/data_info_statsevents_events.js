/*=========================================
    Userrs admin events
    File: views / shared / _data_info_statsevents_events.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsevents_paid').click(function() {
    $("#status_statsevents_paid_content").show();
    $("#status_statsevents_free_content").hide();
  });

  $('#status_statsevents_free').click(function() {
    $("#status_statsevents_free_content").show();
    $("#status_statsevents_paid_content").hide();
  });
});