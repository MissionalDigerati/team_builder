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
        eventBackgroundColor: '#5eb2d9',
        textColor: '#FFFFFF',
        color: '#5eb2d9',
        eventAfterRender: callbackEventsAfterRender
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