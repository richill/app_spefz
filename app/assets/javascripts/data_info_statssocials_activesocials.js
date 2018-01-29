/*=========================================
    Userrs admin events
    File: views / shared / _data_info_statssocials_activesocials.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statssocials_active_all').click(function() {
    $("#status_statssocials_active_all_content").show();
    $("#status_statssocials_active_live_content").hide();
    $("#status_statssocials_active_upcoming_content").hide();
  });

  $('#status_statssocials_active_live').click(function() {
    $("#status_statssocials_active_live_content").show();
    $("#status_statssocials_active_all_content").hide();
    $("#status_statssocials_active_upcoming_content").hide();
  });

  $('#status_statssocials_active_upcoming').click(function() {
    $("#status_statssocials_active_upcoming_content").show();
    $("#status_statssocials_active_all_content").hide();
    $("#status_statssocials_active_live_content").hide();
  });
});
