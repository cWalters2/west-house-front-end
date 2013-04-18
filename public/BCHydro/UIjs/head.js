var h = 768;
var w = 1024;
var svg;
var temp;
var icon;

var currentTime = new Date();
var month=new Array();
    month[0]="Jan";
    month[1]="Feb";
    month[2]="Mar";
    month[3]="Apr";
    month[4]="May";
    month[5]="June";
    month[6]="July";
    month[7]="Aug";
    month[8]="Sept";
    month[9]="Oct";
    month[10]="Nov";
    month[11]="Dec";
	

//drawTop("body");
$(function () {
	var deferred = $.ajax({
    	url: 'http://free.worldweatheronline.com/feed/weather.ashx?key=80ade92738205915131203&q=burnaby,canada&num_of_days=1&format=json',
    	dataType: 'jsonp',
    	//async: false,
    	contentType: "application/json",
	});

	deferred.success(function (data) {
		getWeatherData(data);
		drawTop("div");
  	});

  	function getWeatherData(data){
  		temp = data.data.current_condition[0].temp_C;
  		icon = data.data.current_condition[0].weatherIconUrl[0].value;
  		console.log(temp + " " + icon);
  	} 
});

function drawTop(dom) {
    svg = d3.select(dom)
        .append("svg")
        .attr("width", w)
        .attr("height", h*8/147);  

    svg.append("rect")
       .attr("x", 0)
       .attr("y", 0)
       .attr("width", w)
       .attr("height", h*8/147)
       .attr("fill", "#333333");

    svg.append("text")
        .text("WestHouse")
        .attr("x", w*2/198)
        .attr("y", h*6/147)
        .attr("font-size", h*5/147)
        .attr("font-family", "sans-serif")
        .attr("fill", "#ffffff");

		svg.append("image")
			    .attr("x", w*32/198)
			    .attr("y", h/145)
		        .attr("width", w*6/198)
		        .attr("height", h*6/145)
		        .attr("xlink:href", icon);
	
			svg.append("text")
				.attr("x", w*38/198)
				.attr("y", h*6/145)
		        .attr("font-size", h*4/145)
		        .attr("font-family", "sans-serif")
				.style("fill", "#ffffff")
				.text(temp+"°C");
        
    var datestring = month[currentTime.getMonth()] + " " + currentTime.getDate() + ", " + currentTime.getFullYear();
    svg.append("svg:text")
        .attr("x", w*173/198)
        .attr("y", h*6/145)
        .text(datestring)
        .attr("font-size", h*3/145)
        .attr("font-family", "sans-serif")
        .attr("fill", "#878986");
    drawClock(svg, w, h);	
}
