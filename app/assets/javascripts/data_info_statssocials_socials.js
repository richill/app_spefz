/*=========================================
    Userrs admin socials
    File: views / shared / _data_info_statssocials_socials.html.erb
  =========================================*/

$(document).ready(function() {
  $('#status_statssocials_all').click(function() {
    $("#status_statssocials_all_content").show();
    $("#status_statssocials_active_content").hide();
    $("#status_statssocials_upcoming_content").hide();
    $("#status_statssocials_expiredclosed_content").hide();
  });

  $('#status_statssocials_active').click(function() {
    $("#status_statssocials_active_content").show();
    $("#status_statssocials_all_content").hide();
    $("#status_statssocials_upcoming_content").hide();
    $("#status_statssocials_expiredclosed_content").hide();
  });

  $('#status_statssocials_upcoming').click(function() {
    $("#status_statssocials_upcoming_content").show();
    $("#status_statssocials_active_content").hide();
    $("#status_statssocials_all_content").hide();
    $("#status_statssocials_expiredclosed_content").hide();
  });

  $('#status_statssocials_expiredclosed').click(function() {
    $("#status_statssocials_expiredclosed_content").show();
    $("#status_statssocials_active_content").hide();
    $("#status_statssocials_upcoming_content").hide();
    $("#status_statssocials_all_content").hide();
  });
});

// display socials uploaded image
function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      $('#imagePreviewSocial').css('background-image', 'url('+e.target.result +')');
      $('#imagePreviewSocial').hide();
      $('#imagePreviewSocial').fadeIn(650);
    }
    reader.readAsDataURL(input.files[0]);
  }
}
$("#imageUploadSocial").change(function() {
  readURL(this);
});
