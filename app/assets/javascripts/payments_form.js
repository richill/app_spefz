/*=========================================
    Page: Payment Form Pg
    File: views/payments/_form.html.erb
  =========================================*/

// displaying stripe form or paypal form depending on selection
$(document).ready(function() {
  $('.payment_paypal').click(function() {
    $(".payment_form_stripe").addClass("hide");
    $(".payment_form_paypal").removeClass("hide");
  });
  $('.payment_visa').click(function() {
    $(".payment_form_paypal").addClass("hide");
    $(".payment_form_stripe").removeClass("hide");
  });
});