# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$(document).on 'change', "input[id^='good_']", (e)->
		$(this).parents(".good").first().find(".save_line").show()
	
	$(document).on 'change', "select[id^='good_']", (e)->
		$(this).parents(".good").first().find(".save_line").show()
	
	
	$(document).on 'click', 'input#market_flag', (e)->
		$(this).parents(".well").first().find(".ui-multiselect").toggle()
		$(this).parents(".well").first().find('.whole_network').toggle()
		
	$(document).on 'click', '.select_all', (e)->	
		$(this).parents(".well").find('input#buyer_flag').prop('checked', true);
    

	$(document).on 'click', '.select_none', (e)->
		$(this).parents(".well").find('input#buyer_flag').prop('checked', false);
		
	$(document).on 'click', '.update_buyers', (e)->
		e.preventDefault()
		markets = "{"
		$("span#modal_form_data").last().find("input[name='market_flag']").each (i, f) ->
			console.log("market: "+$(f).attr('value'))
			buyers = new Array()
			if(!$(f).is(":checked"))
				console.log("market not checked")
				ary = $(f).parents(".well").first().find("select#buyer_flag").val()
				$.each ary, ( ii, b ) ->
					buyers.push(b)
				if( buyers.length >0)
					if markets != "{"
						markets = markets + ","
					markets = markets + "\""+$(f).attr("value") + "\":"+ JSON.stringify(buyers)
			else if $(f).is(":checked")
				console.log("market checked")
				if markets != "{"
					markets = markets + ","
				markets = markets + "\""+ $(f).attr("value") + "\":[]"
		markets = markets + "}"
		target = $(this).attr("data-target")
		$(".buyer_json_"+target).attr("value",markets)
		console.log($(".buyer_json_"+target).val())
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
						old_color = $(self).parents('tr.good').first().children('td').css("background-color")
						$(self).parents('tr.good').first().children('td').css("background-color", "green")
						$(self).parents('tr.good').first().children('td').animate({ backgroundColor: old_color }, 'slow')
					failuer: (e)->
						old_color = $(self).parents('tr.good').first().children('td').css("background-color")
						$(self).parents('tr.good').first().children('td').css("background-color", "red")
						$(self).parents('tr.good').first().children('td').animate({ backgroundColor: old_color }, 'slow');
			
				})
	
	