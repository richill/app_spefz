/*=========================================
    Userrs admin events
    File: views / shared / _data_info_transactions_bookedactiveevents.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_transactions_pymts').click(function() {
    $("#status_transactions_pymts_content").show();
    $("#status_transactions_attlist_content").hide();
    $("#status_transactions_pymts_attlist_nousers_content").hide();
    $("#status_transactions_pymts_attlist_users_content").hide();
  });

  $('#status_transactions_attlist').click(function() {
    $("#status_transactions_attlist_content").show();
    $("#status_transactions_pymts_content").hide();
    $("#status_transactions_pymts_attlist_nousers_content").hide();
    $("#status_transactions_pymts_attlist_users_content").hide();
  });

  $('#status_transactions_pymts_attlist_nousers').click(function() {
    $("#status_transactions_pymts_attlist_nousers_content").show();
    $("#status_transactions_pymts_content").hide();
    $("#status_transactions_attlist_content").hide();
    $("#status_transactions_pymts_attlist_users_content").hide();
  });

  $('#status_transactions_pymts_attlist_users').click(function() {
    $("#status_transactions_pymts_attlist_users_content").show();
    $("#status_transactions_pymts_content").hide();
    $("#status_transactions_attlist_content").hide();
    $("#status_transactions_pymts_attlist_nousers_content").hide();
  });
});