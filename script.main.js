
var timeline
var timeline_from
var timeline_to

$(document).ready(function()
{
	timeline = $("timeline");
	timeline_from = $("timeline").attr("from");
	timeline_to   = $("timeline").attr("to");
	$("body").height("400vh");
	updateTimeline();
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
	updateTimeline();
});

function updateTimeline()
{
	var scrollPercent = $(window).scrollTop()/($("html").height() - $(window).height());

	// Display limits

	if( scrollPercent <= 0 ){ $("#marker_top").css("display","none"); }else{ $("#marker_top").css("display","block"); }
	if( scrollPercent >= 1 ){ $("#marker_bottom").css("display","none"); }else{ $("#marker_bottom").css("display","block"); }

	timeline.children("event").each(function(){
		var event_time = $(this).attr('time');
		var test1 = event_time - timeline_from
		var test2 = timeline_to - timeline_from
		var percent = 100-((test1/test2)*100)
		var verticalPosition = percent - ($(document).scrollTop()/$(document).height());
		verticalPosition = (verticalPosition * 3) - (scrollPercent * 200);

		if (verticalPosition < 0) { $(this).css("display","none"); return }
		if (verticalPosition > 100) { $(this).css("display","none"); return }

		verticalPosition = (verticalPosition > 100) ? 100 : verticalPosition;
		verticalPosition = (verticalPosition < 0) ? 0 : verticalPosition;
		$(this).css("top",verticalPosition+"%").css("display","block");
	});
}

function updateScreenForMobile()
{
	if( $(window).width() < 700 ){
		$("body").addClass("mobile");
	}
	else{
		$("body").removeClass("mobile");
	}	
}
