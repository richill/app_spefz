// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require chosen-jquery
//= require jquery-ui
//= require foundation-datetimepicker
//= require social-share-button
//= require turbolinks
//= require jquery.raty
//= require ratyrate
//= require_tree .

$(function(){ $(document).foundation(); });

// sigin-in alert message | devise signin/signout error messages
$(document).ready(function(){
  setTimeout(function(){
    $('#notice_wrapper').fadeOut("slow", function() {
      $(this).remove();
    })
  }, 2500);
});

// sigin-out alert message | devise signin/signout error messages
$(document).ready(function(){
  setTimeout(function(){
    $('#alert_wrapper').fadeOut("slow", function() {
      $(this).remove();
    })
  }, 2500);
});

// smooth scrolling
$(document).ready(function() {
  $('a[rel="relativeanchor"]').click(function(){
      $('html, body').animate({
          scrollTop: $( $.attr(this, 'href') ).offset().top
      }, 500);
      return false;
  }); 
});


// notifications
$(document).ready(function() {
  // [nav] notificationLink_friendRequest
  $(document).ready(function() {
    $("#notificationLink_friendRequest").click(function() {
      $("#notificationContainer_friendRequest").fadeToggle(300);
      $("#notification_count_friendRequest").fadeOut("slow");
      $("#notificationContainer_invites").fadeOut("slow");
      $("#notificationContainer_bell").fadeOut("slow");
      $("#notificationContainer_comment").fadeOut("slow");
      $("#notificationContainer_profile").fadeOut("slow");
      return false;
    });
    //Document Click hiding the popup 
    $(document).click(function() {
      $("#notificationContainer_friendRequest").hide();
    });
    //Popup on click
    $("#notificationContainer_friendRequest").click(function() {
      return true;
    });
  });

  // [nav] notificationLink_invites
  $(document).ready(function() {
    $("#notificationLink_invites").click(function() {
      $("#notificationContainer_invites").fadeToggle(300);
      $("#notification_count_invites").fadeOut("slow");
      $("#notificationContainer_friendRequest").fadeOut("slow");
      $("#notificationContainer_bell").fadeOut("slow");
      $("#notificationContainer_comment").fadeOut("slow");
      $("#notificationContainer_profile").fadeOut("slow");
      return false;
    });
    //Document Click hiding the popup 
    $(document).click(function() {
      $("#notificationContainer_invites").hide();
    });
    //Popup on click
    $("#notificationContainer_invites").click(function() {
      return true;
    });
  });

  // [nav] notificationLink_bell
  $(document).ready(function() {
    $("#notificationLink_bell").click(function() {
      $("#notificationContainer_bell").fadeToggle(300);
      $("#notification_count_bell").fadeOut("slow");
      $("#notificationContainer_friendRequest").fadeOut("slow");
      $("#notificationContainer_invites").fadeOut("slow");
      $("#notificationContainer_comment").fadeOut("slow");
      $("#notificationContainer_profile").fadeOut("slow");
      return false;
    });
    //Document Click hiding the popup 
    $(document).click(function() {
      $("#notificationContainer_bell").hide();
    });
    //Popup on click
    $("#notificationContainer_bell").click(function() {
      return true;
    });
  });

  // [nav] notificationLink_comment
  $(document).ready(function() {
    $("#notificationLink_comment").click(function() {
      $("#notificationContainer_comment").fadeToggle(300);
      $("#notification_count_comment").fadeOut("slow");
      $("#notificationContainer_friendRequest").fadeOut("slow");
      $("#notificationContainer_invites").fadeOut("slow");
      $("#notificationContainer_bell").fadeOut("slow");
      $("#notificationContainer_profile").fadeOut("slow");
      return false;
    });
    //Document Click hiding the popup 
    $(document).click(function() {
      $("#notificationContainer_comment").hide();
    });
    //Popup on click
    $("#notificationContainer_comment").click(function() {
      return true;
    });
  });

  // [nav] notificationLink_profile
  $(document).ready(function() {
    $("#notificationLink_profile").click(function() {
      $("#notificationContainer_profile").fadeToggle(300);
      $("#notification_count_profile").fadeOut("slow");
      $("#notificationContainer_friendRequest").fadeOut("slow");
      $("#notificationContainer_invites").fadeOut("slow");
      $("#notificationContainer_bell").fadeOut("slow");
      $("#notificationContainer_comment").fadeOut("slow");
      return false;
    });
    //Document Click hiding the popup 
    $(document).click(function() {
      $("#notificationContainer_profile").hide();
    });
    //Popup on click
    $("#notificationContainer_profile").click(function() {
      return true;
    });
  });
});

// jquery-ui datepicker 
$(document).ready(function() {
  $('.datepicker').datepicker({ dateFormat: 'MM dd, yy' }); 
});

$(document).ready(function() {
  $( function() {
    $( ".event_datepicker" ).datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat: 'MM dd, yy'
    });
  });
});

// word count [create/edit social & event page]
$(document).ready(function() {
  var text_max_companyname = 20;
  var text_max_title = 55;
  var text_max_event_title = 55;
  var text_max_blog_title = 55;
  $('#textarea_companyname_feedback').html(text_max_companyname + ' words remaining');
  $('#textarea_title_feedback').html(text_max_title + ' words remaining');
  $('#textarea_title_event').html(text_max_event_title + ' words remaining');
  $('#text_max_event_blog').html(text_max_blog_title + ' words remaining');

  $('#textarea').keyup(function() {
    var regex = /\s+/gi;
    var text_length = $('#textarea').val().trim().replace(regex, ' ').split(' ').length;
    var text_remaining = text_max_companyname - text_length;
    $('#textarea_companyname_feedback').html(text_remaining + ' words remaining');
  });
  $('#social_title').keyup(function() {
    var regex = /\s+/gi;
    var text_length = $('#social_title').val().trim().replace(regex, ' ').split(' ').length;
    var text_remaining = text_max_title - text_length;
    $('#textarea_title_feedback').html(text_remaining + ' words remaining');
  });
  $('#event_title').keyup(function() {
    var regex = /\s+/gi;
    var text_length = $('#event_title').val().trim().replace(regex, ' ').split(' ').length;
    var text_remaining = text_max_event_title - text_length;
    $('#textarea_title_event').html(text_remaining + ' words remaining');
  });
  $('#blog_title').keyup(function() {
    var regex = /\s+/gi;
    var text_length = $('#blog_title').val().trim().replace(regex, ' ').split(' ').length;
    var text_remaining = text_max_blog_title - text_length;
    $('#text_max_event_blog').html(text_remaining + ' words remaining');
  });
});




