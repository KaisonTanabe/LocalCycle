$ ->
	$(document).on 'change', "select[name='good[selling_unit_id]']", (e)->
		self = this
		if( $(this).parents('.wishlist-row').length > 0)
			$(this).parents('.wishlist-row').find('.selling_unit_display').each (i, f)->
				$(f).html(" / " + $(self).find(":selected").text())
				$(f).siblings("input[name$='[selling_unit_id]']").val($(self).val())
