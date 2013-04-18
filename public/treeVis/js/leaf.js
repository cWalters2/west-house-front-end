function Leaf(svg, x, y, scalex, scaley, id, icon) {
	this.svg = svg.append("g").attr("class", "leafLayer"+id); 
	this.x = x;
	this.y = y;
	this.scalex = scalex;
	this.scaley = scaley;
	this.icon = icon;
	this.path;
	this.iconimage;
	this.draw = draw;
	this.redraw = redraw;
	
	function draw() {
		var d = "M " + 5*this.scalex + " 0 " + 
				"S " + 15*this.scalex + " " + 11*this.scaley + " " + 5*this.scalex + " " + 18*this.scaley + " " +
				"M " + 5*this.scalex + " " + 18*this.scaley + " " +
				"S " + (-5*this.scalex) + " " + 13*this.scaley + " " + 5*this.scalex + " 0";
	    this.path = this.svg.append("path")
			.attr("transform", "translate("+this.x+","+this.y+")")
	        .attr("d", d)
	        .attr("fill", "#9cc93a")
			.attr("stroke", "#333333")
			.attr("stroke-width", "2");
		
		this.iconimage = this.svg.append("image")
			.attr("transform", "translate("+this.x+","+this.y+")")
			.attr("x", 0)
			.attr("y", 0)
			.attr("width", this.scalex*10)
			.attr("height", this.scaley*20)
			.attr("xlink:href", this.icon);
	}
	
	function redraw(x, y, scalex, scaley, icon) {
		this.x = x;
		this.y = y;
		this.scalex = scalex;
		this.scaley = scaley;
		this.icon = icon;
		
		var d = "M " + 5*this.scalex + " 0 " + 
				"S " + 15*this.scalex + " " + 11*this.scaley + " " + 5*this.scalex + " " + 18*this.scaley + " " +
				"M " + 5*this.scalex + " " + 18*this.scaley + " " +
				"S " + (-5*this.scalex) + " " + 13*this.scaley + " " + 5*this.scalex + " 0";
		this.path.transition()
				.duration(500)
				.attr("transform", "translate("+this.x+","+this.y+")")
				.attr("d", d);
				
		this.iconimage.transition()
				.attr("transform", "translate("+this.x+","+this.y+")")
				.attr("x", 0)
				.attr("y", 0)
				.attr("width", this.scalex*10)
				.attr("height", this.scaley*20)
				.attr("xlink:href", this.icon);
	}
}

