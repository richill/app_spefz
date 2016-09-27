/*=========================================
    Section: socials page
    File: views / socials / _form.html.erb
  =========================================*/

// filter on gender attendance
$(document).ready(function() {
  $('.general_gender_quantity_content').hide();
  $('.specific_gender_quantity_content').hide();
  $('#social_category_quantitygender_id').change(function() {
    if ($(this).val() == 4) {
      $('.specific_gender_quantity_content').show();
      $('.general_gender_quantity_content').hide();
    } else if ($(this).val() == 1, 2, 3) {
      $('.general_gender_quantity_content').show();
      $('.specific_gender_quantity_content').hide();
    }
  });
});




