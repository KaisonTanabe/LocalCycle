
$ ->
	$(document).on 'change', ".network_change", (e)->
		list = ""
		$('.network_change').each (i,e)->
			if (i>0)
				list = list + ","
			list = list + e.value 
		$("#local_networks").attr("value", list)
