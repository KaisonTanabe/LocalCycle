filters = () -> 
	filter = "&filter="
	$("input:checked[name^='filter[cert_ids]").each (i,w)->
		if (i > 0)
			filter = filter + ","
		filter = filter + $(w).attr("value")
	if $('input#search').val() != ''
		filter= filter + "&search=" + encodeURIComponent($('input#search').val())
	filter



search_and_filter = () ->
		cat_id = ""
		view = ""
		if(typeof $('#product_view').attr('value') != 'undefined') 
			view = "/marketplace"
		
		if(typeof $('#cat_id').attr('value') != 'undefined') 
			cat_id = "&cat_id="+$('#cat_id').attr('value')
		$.ajax '/goods'+view+ '?market_id='+ $("select[name='market[id]']").val()+'network_id='+ $("select[name='network[id]']").val()+cat_id+filters(),
			type: 'GET',
			success: (data, textStatus, jqXHR) ->
				$('.to_replace').html($(data).find('.to_replace').html())
	
$ ->
	
	$(document).on "click", ".search-btn", (e)->
		search_and_filter()

	$(document).on "click", ".filter-button", (e)->
		search_and_filter()

	$("select[name='network[id]']").change (e)->
		self = this
		cat_id = ""
		view = ""
		if(typeof $('#product_view').attr('value') != 'undefined') 
			view = "/marketplace"

		if(typeof $('#cat_id').attr('value') != 'undefined') 
			cat_id = "&cat_id="+$('#cat_id').attr('value')
			
		$.ajax '/goods'+view+ '?network_id='+ $(self).val()+cat_id+filters(),
			type: 'GET',
			success: (data, textStatus, jqXHR) ->
				$('.to_replace').html($(data).find('.to_replace').html())

	$(document).on "change", "select[name='market[id]']", (e)->
		self = this
		cat_id = ""
		view = ""
		if(typeof $('#product_view').attr('value') != 'undefined') 
			view = "/marketplace"
		
		if(typeof $('#cat_id').attr('value') != 'undefined') 
			cat_id = "&cat_id="+$('#cat_id').attr('value')
		$.ajax '/goods'+view+ '?market_id='+ $(self).val()+'network_id='+ $(self).val()+cat_id+filters(),
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
			data: { good_id: $(self).parents('.base_container').find('input#good_id').attr("value"),qty: $(self).parents('.base_container').find('input#cart_item_quantity').val(), market_id: $('#market_id').val(), min_order:$(self).parents('.base_container').find('input#min_order').attr("value"), available: $(self).parents('.base_container').find('input#available').attr("value")  },
			success: (data, textStatus, jqXHR) ->
				if (data =="Not enough quantity available")
					alert(data)
				else
					$('.cart_body').parent().html(data)
				$(self).parents('.base_container').find('input#cart_item_quantity').val(null)
			error: () ->
				alert("Minimum order is " + $(self).parents('.base_container').find('input#min_order').attr("value"))
	
	$(document).on "click", ".filter-toggle", (e)->
		$('.filter-body').toggle()
		$(this).find('.show').toggle()
		$(this).find('.hide').toggle()
	

	$(document).on "click", ".clear-filters", (e)->
		$("input[name^='filter[cert_ids]']").prop('checked', false)

