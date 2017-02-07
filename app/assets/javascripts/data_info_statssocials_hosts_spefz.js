/*=========================================
    Userrs admin stats_socials
    File: views / shared / _data_info_statssocials_hosts_spefz.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_hostsspefz_all').click(function() {
    $("#status_hostsspefz_all_content").show();
    $("#status_hostsspefz_male_content").hide();
    $("#status_hostsspefz_female_content").hide();
  });

  $('#status_hostsspefz_male').click(function() {
    $("#status_hostsspefz_male_content").show();
    $("#status_hostsspefz_all_content").hide();
    $("#status_hostsspefz_female_content").hide();
  });

  $('#status_hostsspefz_female').click(function() {
    $("#status_hostsspefz_female_content").show();
    $("#status_hostsspefz_all_content").hide();
    $("#status_hostsspefz_male_content").hide();
  });
});