startSpinner = ->
  $('#loader').show()

stopSpinner = ->
  $('#loader').hide()

$(document).on("page:fetch", startSpinner)
$(document).on("page:receive", stopSpinner)
