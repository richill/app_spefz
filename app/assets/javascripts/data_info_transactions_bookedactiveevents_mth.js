/*=========================================
    Userrs admin events
    File: views / shared / _data_info_transactions_bookedactiveevents_mth.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_transactions_pymts_heldthismth').click(function() {
    $("#status_transactions_pymts_heldthismth_content").show();
    $("#status_transactions_attlist_heldthismth_content").hide();
    $("#status_transactions_pymts_attlist_nousers_heldthismth_content").hide();
    $("#status_transactions_pymts_attlist_users_heldthismth_content").hide();
  });

  $('#status_transactions_attlist_heldthismth').click(function() {
    $("#status_transactions_attlist_heldthismth_content").show();
    $("#status_transactions_pymts_heldthismth_content").hide();
    $("#status_transactions_pymts_attlist_nousers_heldthismth_content").hide();
    $("#status_transactions_pymts_attlist_users_heldthismth_content").hide();
  });

  $('#status_transactions_pymts_attlist_nousers_heldthismth').click(function() {
    $("#status_transactions_pymts_attlist_nousers_heldthismth_content").show();
    $("#status_transactions_pymts_heldthismth_content").hide();
    $("#status_transactions_attlist_heldthismth_content").hide();
    $("#status_transactions_pymts_attlist_users_heldthismth_content").hide();
  });

  $('#status_transactions_pymts_attlist_users_heldthismth').click(function() {
    $("#status_transactions_pymts_attlist_users_heldthismth_content").show();
    $("#status_transactions_pymts_heldthismth_content").hide();
    $("#status_transactions_attlist_heldthismth_content").hide();
    $("#status_transactions_pymts_attlist_nousers_heldthismth_content").hide();
  });
});