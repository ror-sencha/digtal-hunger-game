// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui.js
//= require turbolinks
//= require bootstrap.min.js
//= require jquery_nested_form
//= require ckeditor/init
//= require jquery.colorbox.js


$(function() {
  $( "#challenge_start_date" ).datepicker();
	$( "#challenge_end_date" ).datepicker();
});

$(document).ready(function(){
	$(".cbox").colorbox();
});
			