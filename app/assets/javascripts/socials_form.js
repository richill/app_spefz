/*=========================================
    Section: socials form page
    File: views / socials / _form.html.erb
  =========================================*/

// filter on gender attendance
// $(document).ready(function() {
//   $('.general_gender_quantity_content').hide();
//   $('.specific_gender_quantity_content').hide();
//   $('#social_category_quantitygender_id').change(function() {
//     if ($(this).val() == 4) {
//       $('.specific_gender_quantity_content').show();
//       $('.general_gender_quantity_content').hide();
//     } else if ($(this).val() == 1, 2, 3) {
//       $('.general_gender_quantity_content').show();
//       $('.specific_gender_quantity_content').hide();
//     }
//   });
// });

$(document).ready(function() {
  $('.general_gender_quantity_content').hide();
  $('.specific_gender_quantity_content').hide();
  $('#social_category_quantitygendersocial_id').change(function() {
    if ($(this).val() == 4) {
      $('.specific_gender_quantity_content').show();
      $('.general_gender_quantity_content').hide();
    } else if ($(this).val() == 1, 2, 3) {
      $('.general_gender_quantity_content').show();
      $('.specific_gender_quantity_content').hide();
    }
  });
});


// hiding the option 'both X men & X women' in the category 'CategoryQuantitygender'
// $(document).ready(function() {
//   $('#social_category_quantitygender_id').find("option[value='4']").addClass("hide")
// });


