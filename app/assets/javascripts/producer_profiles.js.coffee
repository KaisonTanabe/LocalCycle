# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->	
	$("input[name='user[growing_methods]'][ type='hidden']").remove()
	
	$(document).on 'ajax:beforeSend', "a.edit_buyers", (e, xhr, settings)->
		id = settings.url.split('=')[1]
		settings.url = settings.url+"&data="+encodeURIComponent($('.buyer_json_'+id).attr('value'))
		
	$(document).on 'ajax:success', "a.edit_buyers", (event, data, xhr)->
		$('.modal-body').html(data)
		$('.modal-body').find('.network_selector').attr('value', $(this).siblings(".network_value").attr('value'));
		$('#MyModal').modal('show')
		$('.multiselect').multiselect({
			noneSelectedText: "Select Buyers"
		}) 
		$("input[name='market_flag']").each (i, e)->
			if $(this).attr("checked")
				$(this).parents(".well").first().find(".ui-multiselect").hide()
			else
				$(this).parents(".well").first().find(".whole_network").hide()
				
	.bind 'ajax:failure', (xhr, status, error) ->
		alert("failure!")
		

	$(document).on 'ajax:success', "a.good-details-btn", (event, data, xhr)->
		$('.modal-body').html(data)
		$('#MyModal').modal('show')
		$("[data-behavior~='datepicker']").datepicker({
			"format": "yyyy-mm-dd",
			"weekStart": 1,
			"autoclose": true
		})
	.bind 'ajax:failure', (xhr, status, error) ->
		alert("failure!")


	