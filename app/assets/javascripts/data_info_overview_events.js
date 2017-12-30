/*=========================================
    Userrs admin events
    File: views / shared / _data_info_overview_events.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_overviewevents_paid').click(function() {
    $("#status_overviewevents_paid_content").show();
    $("#status_overviewevents_free_content").hide();
  });

  $('#status_overviewevents_free').click(function() {
    $("#status_overviewevents_free_content").show();
    $("#status_overviewevents_paid_content").hide();
  });
});