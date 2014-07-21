$(document).ready(function() {
    $('form').on('click', '.remove_fields', function(event) {
        event.preventDefault();
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('div.repeatable-inputs').slideUp('slow');
    });
    $('form').on('click', '.add_fields', function(event) {
        event.preventDefault();
        var time = new Date().getTime();
        var wrapper_id = 'added-wrapper'+time;
        var regexp = new RegExp($(this).data('id'), 'g');
        var newFields = $('<div />').attr('id', wrapper_id).hide().html($(this).data('fields').replace(regexp, time));
        newFields.find('div.date-picker').datepicker();
        $(this).parents('div.add-fields-link-div').eq(0).before(newFields);
        $('#'+wrapper_id).slideDown('slow');
    });
});
/**
 * Setup the team status selector for choosing the status of the team member
 * @param Integer contactId the id of the contact to update
 * @return void
 */
function setUpTeamStatus(contactId) {
    $('.team-status-change').matchHeight(false);
    $('.team-status-change').click(function(event) {
        var new_status = $(this).data('new-status');
        $('input#contact_team_status').val(new_status);
        $('form#update-team-status').trigger('submit.rails');
    });
};