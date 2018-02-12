/*=========================================
    Userrs admin events
    File: views / shared / _data_info_statsevents_events.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsablbum_allphotos').click(function() {
    $("#status_statsablbum_allphotos_content").show();
    $("#status_statsablbum_publishedphotos_content").hide();
    $("#status_statsablbum_unpublishedphotos_content").hide();
  });

  $('#status_statsablbum_publishedphotos').click(function() {
    $("#status_statsablbum_publishedphotos_content").show();
    $("#status_statsablbum_allphotos_content").hide();
    $("#status_statsablbum_unpublishedphotos_content").hide();
  });

  $('#status_statsablbum_unpublishedphotos').click(function() {
    $("#status_statsablbum_unpublishedphotos_content").show();
    $("#status_statsablbum_allphotos_content").hide();
    $("#status_statsablbum_publishedphotos_content").hide();
  });
});