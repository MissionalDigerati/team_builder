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
//= require jquery_ujs
//= require jquery.ui.all
// Loads all Bootstrap javascripts
//= require bootstrap
//= require bootstrap-dropdown
//= require_self
//= require_tree .

$(document).ready(function(){

	$('#date_select').datepicker({
		dateFormat: "dd-mm-yy"
	});

	$('.date_select').datepicker({
		dateFormat: "dd-mm-yy"
	});

	$('input.state').click(function(event){
		$(this).prevAll().removeAttr('checked');
		$(this).nextAll().removeAttr('checked');
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