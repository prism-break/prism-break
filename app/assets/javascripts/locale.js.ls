$ ->

  $('#language_select').bind 'change', ->
    locale-new = $(this).val!

    url-current = window.location.protocol + '//' + window.location.host + window.location.pathname;

    url-segments = url-current.split('/')
    url-segments[3] = locale-new

    url-new = ''
    for i from 0 til url-segments.length by 1
      url-new += url-segments[i]
      url-new += '/' if url-segments.length > i + 1
      
    window.location.replace url-new
