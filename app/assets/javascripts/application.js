// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_migrate
//= require jquery_ujs
//= require jquery-ui/core
//= require jquery-ui/widget
//= require jquery-ui/mouse
//= require jquery-ui/position
//= require jquery-ui/autocomplete
// Loads all Bootstrap javascripts
//= require bootstrap-sprockets
//= require macadmin/html5shiv
//= require macadmin/excanvas.min
//= require macadmin/filter
//= require macadmin/jquery.cleditor.min
//= require macadmin/jquery.dataTables.min
//= require macadmin/jquery.flot
//= require macadmin/jquery.flot.pie
//= require macadmin/jquery.flot.resize
//= require macadmin/jquery.flot.stack
//= require macadmin/jquery.noty
//= require macadmin/jquery.prettyPhoto
//= require macadmin/jquery.rateit.min
//= require macadmin/jquery.slimscroll.min
//= require macadmin/jquery.onoff.min
//= require macadmin/sparklines
//= require macadmin/charts
//= require macadmin/respond.min
//= require macadmin/layouts/bottom
//= require macadmin/layouts/top
//= require macadmin/layouts/topRight
//= require macadmin/themes/default
//= require fullcalendar/moment.min
//= require fullcalendar/fullcalendar.min
//= require fullcalendar/gcal
//= require tag-it/tag-it.min
//= require macadmin/bootstrap-datepicker
//= require_self
//= require_tree .

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
	
});