/*=========================================
    Userrs admin stats adverts
    File: views / shared / _data_info_statsadverts_adverts.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsadverts_all').click(function() {
    $("#content_status_statsadverts_all").show();
    $("#content_status_statsadverts_live").hide();
    $("#content_status_statsadverts_expired").hide();
  });

  $('#status_statsadverts_live').click(function() {
    $("#content_status_statsadverts_live").show();
    $("#content_status_statsadverts_all").hide();
    $("#content_status_statsadverts_expired").hide();
  });

  $('#status_statsadverts_expired').click(function() {
    $("#content_status_statsadverts_expired").show();
    $("#content_status_statsadverts_all").hide();
    $("#content_status_statsadverts_live").hide();
  });
});