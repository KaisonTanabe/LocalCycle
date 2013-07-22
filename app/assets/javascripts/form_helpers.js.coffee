$(window).on 'page:change', () ->
  # Toggling fields from a radio set
  $(".x-toggle-visible").each (i, element) ->
      $element = $(element)
      $element.change () ->
        if element.checked
          $($element.data('hide')).addClass('hidden')
          $($element.data('show')).removeClass('hidden')
        else
          $($element.data('hide')).removeClass('hidden')
          $($element.data('show')).addClass('hidden')

