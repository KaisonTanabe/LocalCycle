jQuery ($) ->
  $(document).on 'ajax:success', "a.ajax-available", (evt, json) ->
    $a = $(@)
    if json.available
      $a.find('span.label').removeClass('label-important').addClass('label-success')
    else
      $a.find('span.label').removeClass('label-success').addClass('label-important')
    $('#messages').html('<div class="alert alert-success"><a class="close" data-dismiss="alert">×</a><div id="flash_success">'+json.message+'</div></div>')

  $("a.ajax-available").on 'ajax:error', (a,b,c) =>
    $a = $(@)
    $('#messages').html('<div class="alert alert-important"><a class="close" data-dismiss="alert">×</a><div id="flash_success">Something went wrong. We are looking into this error.</div></div>')
