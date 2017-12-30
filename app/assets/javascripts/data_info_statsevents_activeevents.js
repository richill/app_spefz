/*=========================================
    Userrs admin events
    File: views / shared / _data_info_statsevents_activeevents.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsevents_active_paid').click(function() {
    $("#status_statsevents_active_paid_content").show();
    $("#status_statsevents_active_free_content").hide();
  });

  $('#status_statsevents_active_free').click(function() {
    $("#status_statsevents_active_free_content").show();
    $("#status_statsevents_active_paid_content").hide();
  });
});