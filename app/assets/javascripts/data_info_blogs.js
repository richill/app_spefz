/*=========================================
    Userrs admin blogs
    File: views / shared / _data_info_blogs.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statsblogs_all').click(function() {
    $("#status_statsblogs_all_content").show();
    $("#status_statsblogs_published_content").hide();
    $("#status_statsblogs_unpublished_content").hide();
  });

  $('#status_statsblogs_published').click(function() {
    $("#status_statsblogs_published_content").show();
    $("#status_statsblogs_all_content").hide();
    $("#status_statsblogs_unpublished_content").hide();
  });

  $('#status_statsblogs_unpublished').click(function() {
    $("#status_statsblogs_unpublished_content").show();
    $("#status_statsblogs_all_content").hide();
    $("#status_statsblogs_published_content").hide();
  });
});