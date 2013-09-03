$ ->
	
	$('form').on 'click', '.add_fields', (event)->
	    time = new Date().getTime()
	    regexp = new RegExp($(this).data('id'), 'g')
	    $(this).before($(this).data('fields').replace(regexp, time))
	    event.preventDefault()

	$('form').on 'click', '.remove_field', (event)->
		r=confirm("Are you sure that you wish to remove this network?")
		if (r==true)
			$(this).prev('input[type=hidden]').val('1')
			$(this).parents(".well").first().hide()
			$(this).closest('.answer_box').remove()
			event.preventDefault()
			
	$('.activate_user').on "ajax:success", (evt, data, status, xhr)->
		$(this).hide()
	
		 