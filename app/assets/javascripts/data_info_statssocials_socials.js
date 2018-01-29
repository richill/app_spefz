/*=========================================
    Userrs admin socials
    File: views / shared / _data_info_statssocials_socials.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statssocials_all').click(function() {
    $("#status_statssocials_all_content").show();
    $("#status_statssocials_active_content").hide();
    $("#status_statssocials_upcoming_content").hide();
    $("#status_statssocials_expiredclosed_content").hide();
  });

  $('#status_statssocials_active').click(function() {
    $("#status_statssocials_active_content").show();
    $("#status_statssocials_all_content").hide();
    $("#status_statssocials_upcoming_content").hide();
    $("#status_statssocials_expiredclosed_content").hide();
  });

  $('#status_statssocials_upcoming').click(function() {
    $("#status_statssocials_upcoming_content").show();
    $("#status_statssocials_active_content").hide();
    $("#status_statssocials_all_content").hide();
    $("#status_statssocials_expiredclosed_content").hide();
  });

  $('#status_statssocials_expiredclosed').click(function() {
    $("#status_statssocials_expiredclosed_content").show();
    $("#status_statssocials_active_content").hide();
    $("#status_statssocials_upcoming_content").hide();
    $("#status_statssocials_all_content").hide();
  });
});