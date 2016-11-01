# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  topics = $('#q_category_topic_id_eq').html()
  $('#q_category_country_id_eq').change ->
    country = $('#q_category_country_id_eq :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(topics).filter("optgroup[label='#{escaped_country}']").html()
    if options
      $('#q_category_topic_id_eq').html(options)
      $('#q_category_topic_id_eq').parent().show()
    else
      $('#q_category_topic_id_eq').empty()
      $('#q_category_topic_id_eq').parent().hide()
