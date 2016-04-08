
var timeline
var timeline_from
var timeline_to

$(document).ready(function()
{
	updateScreenForMobile();
});

$(window).resize(function()
{
	updateScreenForMobile();
});

$(window).load(function()
{

});

$(window).scroll(function ()
{
});

function updateScreenForMobile()
{
	if( $(window).width() < 700 ){
		$("body").addClass("mobile");
	}
	else{
		$("body").removeClass("mobile");
	}	
}