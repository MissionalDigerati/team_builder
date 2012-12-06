# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
	$('form').on 'click', '.remove_fields', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('fieldset').slideUp('slow')
		event.preventDefault()
		
	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()	
		
	$(".checkbox").click ->
		$(this).closest("td").find("a.completed_button").click()
		
	$("td.believer:contains(\"No\")").parent("tr").addClass "warning"
		
	$('.dropdown-toggle').dropdown()
	
	$(".alert").alert()
	
	$("a.asc").parent("th").addClass "current asc"
	
	$("#search").tooltip
	  selector: ""
	  placement: "bottom"
	  trigger: "focus"
		
