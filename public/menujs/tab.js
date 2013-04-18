var h = 768;
var w = 1024;

drawTab();
function drawTab(){
	svg = d3.select("body")
    	.append("svg")
    	.attr("width", w)
    	.attr("height", h);
	
	var tab1 = svg.append("g")
	    .attr("class", "tab1")
		.style("cursor", "pointer"); 
        
	tab1.append("rect")
	        .attr("x", 0)
	        .attr("y", 0)
	        .attr("rx", 3)
	        .attr("ry", 3)
	        .attr("width", 100)
	        .attr("height", 100);
        
	tab1.append("text")
	        .text("Dashboard")
	        .attr("x", 10)
	        .attr("y", 10)
	        .attr("font-size", 30)
	        .attr("font-family", "sans-serif");

	tab1.on("mouseup", function(evt){

    });
}
