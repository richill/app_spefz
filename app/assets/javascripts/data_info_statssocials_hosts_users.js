/*=========================================
    Userrs admin stats_socials
    File: views / shared / _data_info_statssocials_hosts_users.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_hostsusers_all').click(function() {
    $("#status_hostsusers_all_content").show();
    $("#status_hostsusers_male_content").hide();
    $("#status_hostsusers_female_content").hide();
  });

  $('#status_hostsusers_male').click(function() {
    $("#status_hostsusers_male_content").show();
    $("#status_hostsusers_all_content").hide();
    $("#status_hostsusers_female_content").hide();
  });

  $('#status_hostsusers_female').click(function() {
    $("#status_hostsusers_female_content").show();
    $("#status_hostsusers_all_content").hide();
    $("#status_hostsusers_male_content").hide();
  });
});