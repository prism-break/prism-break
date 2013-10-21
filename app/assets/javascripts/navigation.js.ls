$ ->

  $('.menu_toggle').click (e) ->
    e.prevent-default!
    e.stop-propagation!
    $('#header_menu').slide-toggle!

  $('#header_menu').click (e) ->
    e.stop-propagation!

  $(document).click ->
    $('#header_menu').slide-up!
