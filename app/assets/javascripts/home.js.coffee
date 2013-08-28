# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->	
	$("a.buyer, a.producer, a.food-hub").on 'ajax:success', (staus, data, xhr)->
		$('.modal-body').html(data)
		$('#MyModal').modal('show')
	.bind 'ajax:failure', (xhr, status, error) ->
		alert("failure!")

	$('.dropdown-toggle').dropdown()

	$('.dropdown input, .dropdown label').click (e)-> 
		e.stopPropagation()
	  
