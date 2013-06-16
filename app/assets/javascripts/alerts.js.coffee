# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#slider').change -> 
    $('#slideVal').html($(this).val())
  $('#slideVal').html($('#slider').val())
  $('#alert_action_type').change ->
    type = $(this).val()
    if (type == "Email")
      $('.alert_data label').text('Email Address')
    else
      $('.alert_data label').text('Phone Number')
  if ($('#alert_action_type').val() == "Email")
    $('.alert_data label').text('Email Address')
  else
    $('.alert_data label').text('Phone Number')