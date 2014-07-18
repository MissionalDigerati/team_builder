$(document).ready(function(){

    $('input.support-state-checkbox').click(function(event){
        $('input.support-state-checkbox').attr('checked', false);
        $(this).attr('checked', true);
    });

    $('.wminimize').click(function(e){
      e.preventDefault();
      var $wcontent = $(this).parent().parent().next('.widget-content');
      if($wcontent.is(':visible')) 
      {
        $(this).children('i').removeClass('icon-chevron-up');
        $(this).children('i').addClass('icon-chevron-down');
      }
      else 
      {
        $(this).children('i').removeClass('icon-chevron-down');
        $(this).children('i').addClass('icon-chevron-up');
      }            
      $wcontent.toggle(500);
    });
    /* Handle file inputs to look like buttons */
    $('input[type=file]').bootstrapFileInput();

    /* Handle any dropdowns for bootstrap */
    $('.dropdown-toggle').dropdown();

    /* Add a tooltip to the search input */
    $("#search").tooltip({
        selector: "",
        placement: "bottom",
        trigger: "focus"
    });

    /* Add a class to the table header for ascending order */
    $("a.asc").parent("th").addClass("current asc");

    /* When the page scrolls near the pagination, click the next link */
    if ($('.pagination').length) {
      $(window).scroll(function(event) {
        console.log('here');
        var next_url = $('a.next-page').attr('href');
        console.log(next_url);
        if (next_url && ($(window).scrollTop() > ($(document).height() - $(window).height() - 50))) {
          $('.pagination').html('<img src="/assets/ajax-loader.gif" />');
          $.getScript(next_url);
        };
      });
    };
 
});