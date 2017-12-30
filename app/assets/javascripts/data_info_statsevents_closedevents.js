/*=========================================
    Userrs admin events
    File: views / shared / _data_info_statsevents_closedevents.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsevents_closed_paid').click(function() {
    $("#status_statsevents_closed_paid_content").show();
    $("#status_statsevents_closed_free_content").hide();
  });

  $('#status_statsevents_closed_free').click(function() {
    $("#status_statsevents_closed_free_content").show();
    $("#status_statsevents_closed_paid_content").hide();
  });
});