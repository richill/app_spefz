/*=========================================
    Userrs admin events
    File: views / shared / _data_info_statsevents_unbookedevents.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsevents_unbooked_paid').click(function() {
    $("#status_statsevents_unbooked_paid_content").show();
    $("#status_statsevents_unbooked_free_content").hide();
  });

  $('#status_statsevents_unbooked_free').click(function() {
    $("#status_statsevents_unbooked_free_content").show();
    $("#status_statsevents_unbooked_paid_content").hide();
  });
});