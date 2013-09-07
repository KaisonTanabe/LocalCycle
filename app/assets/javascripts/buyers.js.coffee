$ ->
	$("select[name='network[id]']").change (e)->
		self = this
		$.ajax '/goods?network_id='+ $(self).val(),
			type: 'GET',
			success: (data, textStatus, jqXHR) ->
				$('.to_replace').html($(data).find('.to_replace').html())

	$(document).on "click", "a.add-to-cart", (e)->
		e.preventDefault()
		
		self = this
		if $(this).attr('disabled') == "disabled"
			return
		if ( $(self).parents('td').find('input#cart_item_quantity').val() == "" || $(self).parents('td').find('input#cart_item_quantity').val() == '0')
			alert("Quantity cannot be 0")
			return
		$.ajax $(this).attr('href'),
			type: 'POST',
			data: { good_id: $(self).parents('tr').find('input#good_id').attr("value"),qty: $(self).parents('td').find('input#cart_item_quantity').val() },
			success: (data, textStatus, jqXHR) ->
				$('.cart_body').parent().html(data)
				
