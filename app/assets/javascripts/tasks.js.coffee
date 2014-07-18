jQuery ->
	$("td.task_status:contains('Completed')").parent('tr').addClass "success"
	$("td.task_status:contains('In Progress')").parent('tr').addClass "error"

	# To get the tasks to mark as complete when the check box is clicked,
	#   there is a hidden link that is submitted that updates the task.     
	$(".checkbox").click ->
		$(this).closest("td").find("a.completed_button").click()