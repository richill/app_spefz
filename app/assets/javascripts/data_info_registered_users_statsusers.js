/*=========================================
    Userrs admin overview
    File: views / shared / _data_info_registered_users.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsusers_all').click(function() {
    $("#status_statsusers_all_content").show();
    $("#status_statsusers_male_content").hide();
    $("#status_statsusers_female_content").hide();
    $("#status_statsusers_dummies_content").hide();
    $("#status_statsusers_rated_content").hide();
    $("#status_statsusers_nonrated_content").hide();
  });

  $('#status_statsusers_male').click(function() {
    $("#status_statsusers_male_content").show();
    $("#status_statsusers_all_content").hide();
    $("#status_statsusers_female_content").hide();
    $("#status_statsusers_dummies_content").hide();
    $("#status_statsusers_rated_content").hide();
    $("#status_statsusers_nonrated_content").hide();
  });

  $('#status_statsusers_female').click(function() {
    $("#status_statsusers_female_content").show();
    $("#status_statsusers_all_content").hide();
    $("#status_statsusers_male_content").hide();
    $("#status_statsusers_dummies_content").hide();
    $("#status_statsusers_rated_content").hide();
    $("#status_statsusers_nonrated_content").hide();
  });

  $('#status_statsusers_dummies').click(function() {
    $("#status_statsusers_dummies_content").show();
    $("#status_statsusers_all_content").hide();
    $("#status_statsusers_male_content").hide();
    $("#status_statsusers_female_content").hide();
    $("#status_statsusers_rated_content").hide();
    $("#status_statsusers_nonrated_content").hide();
  });

  $('#status_statsusers_rated').click(function() {
    $("#status_statsusers_rated_content").show();
    $("#status_statsusers_all_content").hide();
    $("#status_statsusers_male_content").hide();
    $("#status_statsusers_female_content").hide();
    $("#status_statsusers_dummies_content").hide();
    $("#status_statsusers_nonrated_content").hide();
  });

  $('#status_statsusers_nonrated').click(function() {
    $("#status_statsusers_nonrated_content").show();
    $("#status_statsusers_all_content").hide();
    $("#status_statsusers_male_content").hide();
    $("#status_statsusers_female_content").hide();
    $("#status_statsusers_dummies_content").hide();
    $("#status_statsusers_rated_content").hide();
  });
});