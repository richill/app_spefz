/*=========================================
    Userrs admin stats_events
    File: views / shared / _data_info_statsevents_ratingsevents.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsevents_rated').click(function() {
    $("#status_statsevents_rated_content").show();
    $("#status_statsevents_nonrated_content").hide();
  });

  $('#status_statsevents_nonrated').click(function() {
    $("#status_statsevents_nonrated_content").show();
    $("#status_statsevents_rated_content").hide();
  });
});