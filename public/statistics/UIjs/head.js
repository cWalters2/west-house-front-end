var h = 768;
var w = 1024;
var svg;

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
	

drawTop("body");

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
