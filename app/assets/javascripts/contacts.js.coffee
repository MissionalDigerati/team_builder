# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	# this function removes fields from the create contact page. eg special dates, phone numbers, and web presences. 
	$('form').on 'click', '.remove_fields', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('fieldset').slideUp('slow')
		event.preventDefault()
	# this will add extra fields as needed on the create contact form / page. 	
	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()	
		$(".due_date_field").datepicker dateFormat: "dd-mm-yy"
		
	# To get the tasks to mark as complete when the check box is clicked,
	# 	there is a hidden link that is submitted that updates the task. 	
	$(".checkbox").click ->
		$(this).closest("td").find("a.completed_button").click()
		
	# on the contact show page, if the contact is a non believer then that tr is added a class of warning, 
	# 	in this case bootstrap kicks in and tints the field yellow	
	$("td.believer:contains(\"No\")").parent("tr").addClass "warning"
	
	#this function is built into bootstrap, it puts the tags on the contact index page into a drop down menu. 	
	$('.dropdown-toggle').dropdown()
	
	$(".alert").alert()
	
	$("a.asc").parent("th").addClass "current asc"
	
	# adds the drop down info on focus for the search bar
	$("#search").tooltip
	  selector: ""
	  placement: "bottom"
	  trigger: "focus"

	
	