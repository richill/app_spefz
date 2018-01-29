/*=========================================
    Userrs admin socials
    File: views / shared / data_info_statssocials_activesocials_held_this_mth.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statssocials_mth_all').click(function() {
    $("#status_statssocials_mth_all_content").show();
    $("#status_statssocials_mth_live_content").hide();
    $("#status_statssocials_mth_upcoming_content").hide();
  });

  $('#status_statssocials_mth_live').click(function() {
    $("#status_statssocials_mth_live_content").show();
    $("#status_statssocials_mth_all_content").hide();
    $("#status_statssocials_mth_upcoming_content").hide();
  });

  $('#status_statssocials_mth_upcoming').click(function() {
    $("#status_statssocials_mth_upcoming_content").show();
    $("#status_statssocials_mth_all_content").hide();
    $("#status_statssocials_mth_live_content").hide();
  });
});