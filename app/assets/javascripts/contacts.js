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