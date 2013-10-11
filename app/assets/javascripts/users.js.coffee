$ ->
	
	$('form').on 'click', '.add_fields', (event)->
	    time = new Date().getTime()
	    regexp = new RegExp($(this).data('id'), 'g')
	    $(this).before($(this).data('fields').replace(regexp, time))
	    event.preventDefault()

	$('form').on 'click', '.remove_field', (event)->
		r=confirm("Are you sure that you wish to remove this network?")
		url = $(this).data('url')
		nid = $(this).data('network-id')
		
		if (r==true)
			if(typeof url != "undefined")
				$.ajax url,
					type: 'POST',
					data: {network_id: nid},
					success: (data, textStatus, jqXHR) ->
						location.reload()
			$(this).prev('input[type=hidden]').val('1')
			$(this).parents(".well").first().hide()
			$(this).closest('.answer_box').remove()
			event.preventDefault()

	$('.network-approval').on 'click', (event)->
		event.preventDefault()
		url = $(this).data('url')
		nid = $(this).data('network-id')
		$.ajax url,
			type: 'POST',
			data: {network_id: nid},
			success: (data, textStatus, jqXHR) ->
				location.reload()
				
	$(document).on "ajax:success", '.activate_user', (evt, data, status, xhr)->
		$(this).hide()
	
		 