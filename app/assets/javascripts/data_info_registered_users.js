/*=========================================
    Userrs admin overview
    File: views / shared / _data_info_registered_users.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_users_all').click(function() {
    $("#status_users_all_content").show();
    $("#status_users_male_content").hide();
    $("#status_users_female_content").hide();
  });

  $('#status_users_male').click(function() {
    $("#status_users_male_content").show();
    $("#status_users_all_content").hide();
    $("#status_users_female_content").hide();
  });

  $('#status_users_female').click(function() {
    $("#status_users_female_content").show();
    $("#status_users_all_content").hide();
    $("#status_users_male_content").hide();
  });
});