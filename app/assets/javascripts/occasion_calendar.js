/**
 * Setup the calendar for the occasions.  Run this method once the document is loaded.
 *
 * @param String eventsPath the path to events JSON data
 * @return void
 */
function setUpCalendar(eventsPath) {
    $('#special-dates-calendar').fullCalendar({
        'header': {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        'events': eventsPath,
        eventAfterRender: callbackEventsAfterRender,
        eventClick: callbackEventsClicked
    });
};
/**
 * The callback after the event is rendered on the screen
 *
 * @param Object event the event JSON object
 * @param Object element the element JQuery object that contains the event
 * @return void
 */
function callbackEventsAfterRender(event, element) {
    element.popover({
                title: event.title,
                trigger: 'hover',
                placement: 'top',
                html: true,
                content: "<strong>"+event.date_formatted+"</strong>: "+event.title+"<br><em>Contact: "+event.contact.name+"</em><br>",
                container: 'body'
            });
};
/**
 * The callback after the event is clicked
 *
 * @param Object event the event JSON object
 * @param Object jsEvent the native javascript event
 * @param Object view the current view object
 * @return void
 */
function callbackEventsClicked(event, jsEvent, view) {
    $('#manage-occasion-modal').find('#occasion-title-holder').text(event.title);
    $('#manage-occasion-modal').find('a#edit-occasion-link').attr('href', event.editOccasionLink);
    console.log(event.contact);
    if ($.isEmptyObject(event.contact)) {
        $('a#occasion-view-contact-link').attr('href', '#').addClass('disabled');
        $('#manage-occasion-modal').find('#occasion-body-holder div.contact-details').html("<strong>"+event.date_formatted+"</strong>: "+event.title+"<br>");
        var image = $('<img/>').attr({'src': '/images/missing/thumb/missing.png'}).css({'width': '100%'});
    } else {
        $('a#occasion-view-contact-link').removeClass('disabled');
        $('#manage-occasion-modal').find('a#occasion-view-contact-link').attr('href', event.contact.viewContactLink);
        $('#manage-occasion-modal').find('#occasion-body-holder div.contact-details').html("<strong>"+event.date_formatted+"</strong>: "+event.title+"<br><em>Contact: "+event.contact.name+"</em><br>");
        var image = $('<img/>').attr({'src': event.contact.imagePath}).css({'width': '100%'});
    };
    $('#manage-occasion-modal').find('#occasion-body-holder div.contact-image').html('').append(image);
    $('#manage-occasion-modal').find('a#delete-occasion-link').attr('href', event.deleteOccasionLink);
    $('#manage-occasion-modal').modal('show');
};