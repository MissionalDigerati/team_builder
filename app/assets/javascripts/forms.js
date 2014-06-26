/**
 * Handle the country selector
 */
function handleStateCountrySelectors(ctrySelEle, stateSelEle, provSelEle, stateHolderEle, provHolderEle) {
    if ($.trim($(ctrySelEle+" option:selected" ).text().toLowerCase()) != 'united states') {
        $(stateHolderEle).fadeOut('slow', function() {
            $(stateSelEle+" option").filter(function() {
                return $.trim($(this).text().toLowerCase()) == 'no state'; 
            }).prop('selected', true);
            $(provHolderEle).fadeIn('slow');
        });
    };
    $(ctrySelEle).on('change', function() {
        var val = $(this).find("option:selected").text().toLowerCase();
        if (val != 'united states') {
            $(stateHolderEle).fadeOut('slow', function() {
                $(stateSelEle+" option").filter(function() {
                    return $.trim($(this).text().toLowerCase()) == 'no state'; 
                }).prop('selected', true);
                $(provHolderEle).fadeIn('slow');
            });
        } else {
            $(provHolderEle).fadeOut('slow', function() {
                $(provSelEle).val('');
                $(stateSelEle+" option").filter(function() {
                    return $.trim($(this).text().toLowerCase()) == 'california'; 
                }).prop('selected', true);
                $(stateHolderEle).fadeIn('slow');
            });
        };
    });
};