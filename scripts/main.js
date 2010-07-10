$(document).ready(function(){
	// Toggle overflow on code blocks.
	$('head').append($("<style type='text/css'>pre{overflow:hidden}<\/style>"));
	$('pre').hover(function(){
	    $(this).addClass('overflow_visible_hover');
	}, function(){
	    $(this).removeClass('overflow_visible_hover');
	});
	$('pre').click(function(){
	    $(this).toggleClass('overflow_visible_sticky');
	});
});