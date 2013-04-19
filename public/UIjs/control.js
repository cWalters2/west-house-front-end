var h = 622;
var w = 410;
var svg;
var home = 1;
var away = 0;
var sleep = 0;
var work = 0;
var party = 0;
var colorOff = "#a4a3a3";
var colorOn = "#57bce7";
var colorText = "#626364";
var livingtemp = 20;
var lofttemp = 22;

drawControls(".control");

function drawControls(dom) {
	var h = 622;
	var w = 410;
    svg = d3.select(dom)
        .append("svg")
        .attr("width", w)
        .attr("height", h)
		.style("background", "#77787a");
		
	drawButtons();
	
	svg.append("line")
		.attr("x1", 0)
		.attr("y1", 300)
		.attr("x2", w)
		.attr("y2", 300)
		.attr("stroke", "#ffffff");
	
	drawTextbox();
}

function drawTextbox(){
	svg.append("text")
		.attr("x", 30)
		.attr("y", 350)
		.text("LIVING")
		.attr("font-family", "arial")
		.attr("font-size", "16")
		.attr("fill", "#ffffff");	

	svg.append("text")
		.attr("x", 220)
		.attr("y", 350)
		.text("LOFT")
		.attr("font-family", "arial")
		.attr("font-size", "16")
		.attr("fill", "#ffffff");	
		
	svg.append("text")
		.attr("x", 31)
		.attr("y", 435)
		.text("NOW HEATING")
		.attr("font-family", "arial")
		.attr("font-size", "9")
		.attr("fill", colorOn);	
			
    var livingText = svg.append("g");
	livingText.append("rect")
    	.attr("x", 30)
    	.attr("y", 370)
   	 	.attr("rx", 5)
   	 	.attr("ry", 5)
    	.attr("width", 70)
    	.attr("height", 50)
   		.attr("fill", colorText);

    livingText.append("text")
		.attr("x", 35)
		.attr("y", 405)
		.text(livingtemp + "C")
		.attr("font-family", "arial")
		.attr("font-size", "30")
		.attr("fill", colorOn);
			
	var loftText = svg.append("g");	
	loftText.append("rect")
	    .attr("x", 220)
	   	.attr("y", 370)
	 	.attr("rx", 5)
		.attr("ry", 5)
	    .attr("width", 70)
	    .attr("height", 50)
	   	.attr("fill", colorText);
		
	loftText.append("text")
		.attr("x", 225)
		.attr("y", 405)
		.text(lofttemp + "C")
		.attr("font-family", "arial")
		.attr("font-size", "30")
		.attr("fill", colorOn);

	var livingUpBtn = svg.append("g").style("cursor", "pointer"); 	
	livingUpBtn.append("image")
		.attr("x", 110)
		.attr("y", 370)
		.attr("width", 40)
		.attr("height", 25)
		.attr("xlink:href", "./images/up.png") 

	livingUpBtn.on("mouseup", function(evt){
		livingtemp++;
		livingText.select("text")
			.text(livingtemp + "C");
	});

	var livingDownBtn = svg.append("g").style("cursor", "pointer"); 	
	livingDownBtn.append("image")
		.attr("x", 110)
		.attr("y", 395)
		.attr("width", 40)
		.attr("height", 25)
		.attr("xlink:href", "./images/down.png") 

	livingDownBtn.on("mouseup", function(evt){
			livingtemp--;
			livingText.select("text")
				.text(livingtemp + "C");
		});

	var loftUpBtn = svg.append("g").style("cursor", "pointer"); 	
	loftUpBtn.append("image")
		.attr("x", 300)
		.attr("y", 370)
		.attr("width", 40)
		.attr("height", 25)
		.attr("xlink:href", "./images/up.png") 

	loftUpBtn.on("mouseup", function(evt){
		lofttemp++;
		loftText.select("text")
		.text(lofttemp + "C");
	});

	var loftDownBtn = svg.append("g").style("cursor", "pointer");
	loftDownBtn.append("image")
		.attr("x", 300)
		.attr("y", 395)
		.attr("width", 40)
		.attr("height", 25)
		.attr("xlink:href", "./images/down.png") 
		
	loftDownBtn.on("mouseup", function(evt){
		lofttemp--;
		loftText.select("text")
		.text(lofttemp + "C");
	});
}

function drawButtons(){
	svg.append("text")
		.attr("x", 30)
		.attr("y", 35)
		.text("PRESETS")
		.attr("font-family", "arial")
		.attr("font-size", "16")
		.attr("fill", "#ffffff");
	
    var homeButton = svg.append("g").style("cursor", "pointer"); 
	homeButton.append("rect")
       .attr("x", 30)
       .attr("y", 50)
	   .attr("rx", 10)
	   .attr("ry", 10)
       .attr("width", 90)
       .attr("height", 90)
	   .attr("stroke", "#ffffff")
	   .attr("fill", colorOn);
	   
	homeButton.append("text")
	   .text("HOME")
       .attr("x", 50)
       .attr("y", 100)
	   .attr("font-family", "arial")
	   .attr("font-size", "16")
	   .attr("fill", "#ffffff");
	   
	homeButton.on("mouseup", function(evt){
		if(home == 0){
			home = 1;
			away = 0;
			work = 0;
			sleep = 0;
			party = 0;
			homeButton.select("rect").attr("fill", colorOn);
			awayButton.select("rect").attr("fill", colorOff);
			sleepButton.select("rect").attr("fill", colorOff);
			workButton.select("rect").attr("fill", colorOff);
			partyButton.select("rect").attr("fill", colorOff);
		}
	});

    var awayButton = svg.append("g").style("cursor", "pointer"); 
	awayButton.append("rect")
       .attr("x", 150)
       .attr("y", 50)
   	   .attr("rx", 10)
   	   .attr("ry", 10)
       .attr("width", 90)
	   .attr("height", 90)
	   .attr("stroke", "#ffffff")
   	   .attr("fill", colorOff); 	   

	awayButton.append("text")
   	   .text("AWAY")
       .attr("x", 170)
       .attr("y", 100)
   	   .attr("font-family", "arial")
       .attr("font-size", "16")
       .attr("fill", "#ffffff");

   	awayButton.on("mouseup", function(evt){
   		if(away == 0){
			home = 0;
			away = 1;
			work = 0;
			sleep = 0;
			party = 0;
			homeButton.select("rect").attr("fill", colorOff);
			awayButton.select("rect").attr("fill", colorOn);
			sleepButton.select("rect").attr("fill", colorOff);
			workButton.select("rect").attr("fill", colorOff);
			partyButton.select("rect").attr("fill", colorOff);

   		}
   	});
	
    var sleepButton = svg.append("g").style("cursor", "pointer"); 
	sleepButton.append("rect")
       .attr("x", 270)
       .attr("y", 50)
   	   .attr("rx", 10)
  	   .attr("ry", 10)
       .attr("width", 90)
   	   .attr("height", 90)
	   .attr("stroke", "#ffffff")
       .attr("fill", colorOff); 

   	sleepButton.append("text")
       .text("SLEEP")
       .attr("x", 290)
       .attr("y", 100)
   	   .attr("font-family", "arial")
       .attr("font-size", "16")
	   .attr("fill", "#ffffff");

    sleepButton.on("mouseup", function(evt){
       if(sleep == 0){
   			home = 0;
   			away = 0;
   			work = 0;
   			sleep = 1;
   			party = 0;
   			homeButton.select("rect").attr("fill", colorOff);
   			awayButton.select("rect").attr("fill", colorOff);
   			sleepButton.select("rect").attr("fill", colorOn);
   			workButton.select("rect").attr("fill", colorOff);
   			partyButton.select("rect").attr("fill", colorOff);

      	}
    });
		
   var workButton = svg.append("g").style("cursor", "pointer"); 
   workButton.append("rect")
       .attr("x", 30)
       .attr("y", 170)
	   .attr("rx", 10)
   	   .attr("ry", 10)
       .attr("width", 90)
       .attr("height", 90)
   	   .attr("stroke", "#ffffff")
       .attr("fill", colorOff); 

   workButton.append("text")
       .text("SLEEP")
       .attr("x", 50)
       .attr("y", 220)
       .attr("font-family", "arial")
       .attr("font-size", "16")
   	   .attr("fill", "#ffffff");
	   	   
   workButton.on("mouseup", function(evt){
       if(work == 0){
      		home = 0;
      		away = 0;
      		work = 1;
      		sleep = 0;
     		party = 0;
     		homeButton.select("rect").attr("fill", colorOff);
  			awayButton.select("rect").attr("fill", colorOff);
		    sleepButton.select("rect").attr("fill", colorOff);
      		workButton.select("rect").attr("fill", colorOn);
      		partyButton.select("rect").attr("fill", colorOff);
        }
   });
	   	   
   var partyButton = svg.append("g").style("cursor", "pointer"); 
   partyButton.append("rect")
       .attr("x", 150)
       .attr("y", 170)
	   .attr("rx", 10)
   	   .attr("ry", 10)
       .attr("width", 90)
       .attr("height", 90)
   	   .attr("stroke", "#ffffff")
       .attr("fill", colorOff); 
	   
   partyButton.append("text")
       .text("PARTY")
       .attr("x", 170)
       .attr("y", 220)
   	   .attr("font-family", "arial")
       .attr("font-size", "16")
  	   .attr("fill", "#ffffff");
	   
   partyButton.on("mouseup", function(evt){
	   if(party == 0){
     		home = 0;
      		away = 0;
      		work = 0;
      		sleep = 0;
      		party = 1;
      		homeButton.select("rect").attr("fill", colorOff);
      		awayButton.select("rect").attr("fill", colorOff);
      		sleepButton.select("rect").attr("fill", colorOff);
      		workButton.select("rect").attr("fill", colorOff);
      		partyButton.select("rect").attr("fill", colorOn);
       }
   });
}