# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#This funciton adds classes to the tr elements that contain information pertaining to tasks. 
#This will make them either green or red to show their status of being completed or incomplete. 
jQuery ->
	$("td.task_status:contains('Completed')").parent('tr').addClass "success"
	$("td.task_status:contains('In Progress')").parent('tr').addClass "error"