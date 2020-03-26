$(document).ready(function() {
	$("#nav1 a").each(function() {
		if($(this).attr("class") != "active") {
			$(this).mouseout(function() {
				$(this).attr("class", "");
			});
		}
		$(this).mouseover(function() {
			$(this).attr("class", "active");
		});
		$(this).click(function() {
			$(this).attr("class", "active");
		});
	});
	$("#login a").each(function() {
		$(this).mouseover(function() {
			$(this).attr("class", "active");
		});
		$(this).mouseout(function() {
			$(this).attr("class", "");

		});
	});

});