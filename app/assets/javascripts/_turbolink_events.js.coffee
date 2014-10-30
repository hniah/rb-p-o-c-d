startSpinner = (e) ->
  url = document.URL
  if url.indexOf('time_slots') > 0
    $('#loader').show()

stopSpinner = ->
  $('#loader').hide()

$(document).on("page:fetch", startSpinner)
$(document).on("page:receive", stopSpinner)
