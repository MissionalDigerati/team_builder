jQuery ->
	# this function removes fields from the create contact page. eg special dates, phone numbers, and web presences. 
	$('form').on 'click', '.remove_fields', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('div.repeatable-inputs').slideUp('slow')
		event.preventDefault()
	# this will add extra fields as needed on the create contact form / page. 	
	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		wrapper_id = 'added-wrapper'+time
		regexp = new RegExp($(this).data('id'), 'g')
		newFields = $('<div />').attr('id', wrapper_id).hide().html($(this).data('fields').replace(regexp, time))
		newFields.find('div.date-picker').datepicker()
		$(this).parents('div.add-fields-link-div').eq(0).before(newFields)
		$('#'+wrapper_id).slideDown('slow')
		event.preventDefault()
	