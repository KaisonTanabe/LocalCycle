net_store = ""

rebuild_network_list = ()->
	list = ""
	net_store = ""
	$('.network_change:visible').each (i,e)->
		if (i>0)
			list = list + ","
		list = list + e.value
	net_store = list 
	

	
$ ->

	$(document).on 'click', ".update_user_btn", (e)->
		$('.network_change option').prop('disabled', false)		

	$(document).on 'click', ".add_fields", (e)->
		rebuild_network_list()
		$('.network_change option').prop('disabled', false)
		$('.network_change').each (i, e)->
			$(e).find('option').each (ii, option)->
				if jQuery.inArray(option.value, net_store.split(',')) > -1
					$(option).prop('disabled', true)
			

	$('.export-button').click (e)->
		e.preventDefault()