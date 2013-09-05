# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$(document).on 'change', "input[id^='good_']", (e)->
		$(this).parents(".good").first().find(".save_line").show()
	
	$(document).on 'change', "select[id^='good_']", (e)->
		$(this).parents(".good").first().find(".save_line").show()
	
	
	$(document).on 'click', 'input#market_flag', (e)->
		$(this).parents(".well").first().find("input#buyer_flag").toggle()
		$(this).parents(".well").first().find('.button_bar').toggle()
		
	$(document).on 'click', '.select_all', (e)->	
		$(this).parents(".well").find('input#buyer_flag').prop('checked', true);
    

	$(document).on 'click', '.select_none', (e)->
		$(this).parents(".well").find('input#buyer_flag').prop('checked', false);
		
	$(document).on 'click', '.update_buyers', (e)->
		e.preventDefault()
		markets = "{"
		$("span#modal_form_data").last().find("input[name='market_flag']").each (i, f) ->
			buyers = new Array()
			$(f).parents(".well").find("input[id='buyer_flag']:checked").each (ii, b)->
				  buyers.push($(b).attr("value"))
			if( buyers.length >0)
				if markets != "{"
					markets = markets + ","
				markets = markets + "\""+$(f).attr("value") + "\":"+ JSON.stringify(buyers)
			else if $(f).is(":checked")
				if markets != "{"
					markets = markets + ","
				markets = markets + "\""+ $(f).attr("value") + "\":[]"
		markets = markets + "}"
		target = $(this).attr("data-target")
		$(".buyer_json_"+target).attr("value",markets)
		$('#MyModal').modal('hide')
		$(".buyer_json_"+target).parents(".good").first().find(".save_line").show()
		
	
	$(document).on 'click', '.save_line', (e)->
		self = this
		e.preventDefault()
		data = ''
		url = $(self).data('url') 	
		
		$('form').each (i, o) ->
			if $(o).attr("action") == url
				bdiv = $(o).parent('tr.good')
				$(bdiv).children('td').appendTo(o)
				data = $(o).serialize()
				$(o).children().appendTo(bdiv)
				
				$.ajax({
					type: "PUT",
					url: url,
					data: data + "&render=false",
					success: (e)->
						$(self).hide()
			
				})
	
	