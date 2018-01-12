/*=========================================
    Userrs admin inquiries page | Other Inquiries tab
    File: views / shared / _data_info_inquiries_other.html.erb
  =========================================*/

$(document).ready(function() {
  $('#contact_inquiry_all').click(function() {
    $("#contact_inquiry_all_content").show();
    $("#contact_inquiry_suggestions_content").hide();
    $("#contact_inquiry_marketing_content").hide();
    $("#contact_inquiry_affiliates_content").hide();
    $("#contact_inquiry_suggestedp_content").hide();
    $("#contact_inquiry_workwithus_content").hide();
  });

  $('#contact_inquiry_suggestions').click(function() {
    $("#contact_inquiry_suggestions_content").show();
    $("#contact_inquiry_all_content").hide();
    $("#contact_inquiry_marketing_content").hide();
    $("#contact_inquiry_affiliates_content").hide();
    $("#contact_inquiry_suggestedp_content").hide();
    $("#contact_inquiry_workwithus_content").hide();
  });

  $('#contact_inquiry_marketing').click(function() {
    $("#contact_inquiry_marketing_content").show();
    $("#contact_inquiry_all_content").hide();
    $("#contact_inquiry_suggestions_content").hide();
    $("#contact_inquiry_affiliates_content").hide();
    $("#contact_inquiry_suggestedp_content").hide();
    $("#contact_inquiry_workwithus_content").hide();
  });

  $('#contact_inquiry_affiliates').click(function() {
    $("#contact_inquiry_affiliates_content").show();
    $("#contact_inquiry_all_content").hide();
    $("#contact_inquiry_suggestions_content").hide();
    $("#contact_inquiry_marketing_content").hide();
    $("#contact_inquiry_suggestedp_content").hide();
    $("#contact_inquiry_workwithus_content").hide();
  });

  $('#contact_inquiry_suggestedp').click(function() {
    $("#contact_inquiry_suggestedp_content").show();
    $("#contact_inquiry_all_content").hide();
    $("#contact_inquiry_suggestions_content").hide();
    $("#contact_inquiry_marketing_content").hide();
    $("#contact_inquiry_affiliates_content").hide();
    $("#contact_inquiry_workwithus_content").hide();
  });

  $('#contact_inquiry_workwithus').click(function() {
    $("#contact_inquiry_workwithus_content").show();
    $("#contact_inquiry_all_content").hide();
    $("#contact_inquiry_suggestions_content").hide();
    $("#contact_inquiry_marketing_content").hide();
    $("#contact_inquiry_affiliates_content").hide();
    $("#contact_inquiry_suggestedp_content").hide();
  });
});







