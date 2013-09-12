# this sets up the ajax loader, and it will stay until the method specific js removes it

$('a[data-target=#ajax-modal]').on 'click', ->
   e.preventDefault()
   e.stopPropagation();
   $('body').modalmanager('loading');
   $.rails.handleRemote( $(this) );
#removes whatever is in the modal body content div upon clicking close/outside modal
$(document).on 'click', '[data-dismiss=modal], .modal-scrollable', ->
  $('.modal-body-content').empty()
$(document).on 'click', '#ajax-modal', (e) ->
  e.stopPropagation();
