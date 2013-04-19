﻿var w = 829;var h = 621.7;var svg;var tree;var meter;var pointer;var leafLayer;var berryLayer;var leaves;var berries;var data;var appliances;var maxDayEnergy = 80;var reset = false;d3.text("http://energyvis.iat.sfu.ca/treeVis2/php/db.php", function(loaddata) {    data = d3.csv.parseRows(loaddata);    getApplianceData();     drawTree();	drawMeter();	drawLeaves();	drawBerries();        var interval = setInterval(function() {    d3.text("http://energyvis.iat.sfu.ca/treeVis2/php/updateDB.php", function(loaddata) {        data = d3.csv.parseRows(loaddata);        updateApplianceData(); 		updateLeaves();		updateBerries(); 		updateMeter();    });}, 500);});function getApplianceData() {    appliances = new Array();    berries = new Array();    data.forEach(function(d) {        name = d[1];        room = d[2];        watt = d[3];        posx = parseFloat(d[4]);        posy = parseFloat(d[5]);                status = d[6];        energy = parseFloat(d[7]);        action = d[8];        positive = d[9];        negative = d[10];        lx1 = parseFloat(d[11]);        ly1 = parseFloat(d[12]);        lx2 = parseFloat(d[13]);        ly2 = parseFloat(d[14]);		icon = d[15];		iconx = parseFloat(d[16]);		icony = parseFloat(d[17]);        var a = new Appliance(name, room, watt, status, action, positive, negative, energy, posx, posy, lx1, ly1, lx2, ly2, icon, iconx, icony);        appliances.push(a);		        if(action == 1) {			//console.log(lx1+" "+ly1+" "+lx2+" "+ly2);            var a = (ly2-ly1)/(lx2-lx1);            var b = ly1 - (a*lx1);			//console.log(a+" "+b);            for(var j = 0; j < positive; j++) {                px = Math.random()*(lx2-lx1)+Math.floor(lx1);                py = a*px + b;                           image = "./images/Icons/TreeVis_Berry.png";                var berry = new Berry(px, py, image);                berries.push(berry);				//console.log(px+" "+py);            }        }    });    appliances.splice(0, 1);}function updateApplianceData() {    reset = false;    data.forEach(function(d, i) {        appliances[i].status = d[1];        appliances[i].energy = parseFloat(d[2]);        appliances[i].size = getSize(appliances[i].energy);		appliances[i].icon = getIcon(d[5], appliances[i].status);		        var a = (appliances[i].ly2-appliances[i].ly1)/(appliances[i].lx2-appliances[i].lx1);        var b = appliances[i].ly1 - a*appliances[i].lx1;		        if(appliances[i].positive != d[3]) {			            var num = d[3] - appliances[i].positive;            if (num < 0)                reset = true;            for(var j = 0; j < num; j++) {                px = Math.random()*(appliances[i].lx2-appliances[i].lx1)+Math.floor(appliances[i].lx1);                py = a*px + b;                          image = "./images/Icons/TreeVis_Berry.png";                var berry = new Berry(px, py, image);                berries.push(berry);            }            appliances[i].positive = d[3];        }    });    if(reset)         berries = new Array();}function drawTree() {    svg = d3.select(".tree")        .append("svg")        .attr("width", 1024)        .attr("height", h)		.style("background", "#ffffff");            tree = svg.append("g").attr("class", "tree");     tree.append("image")        .attr("x", 0)        .attr("y", -115)        .attr("width", w)        .attr("height", h*17/15)        .attr("xlink:href", "./images/Tree/TreeVis_Foliage.png");            tree.append("image")        .attr("x", 30)        .attr("y", -15)        .attr("width", w)        .attr("height", h*17.1/15)        .attr("xlink:href", "./images/Tree/TreeVis_Tree.png");	drawRoomText();}function drawRoomText() {		tree.append("text")		.attr("x", w*20/200)		.attr("y", h*91/150)		.attr("font-size", h*3/200)		.attr("font-family", "sans-serif")		.attr("font-weight", "bold")		.text("mechanical");	tree.append("text")		.attr("x", w*6/200)		.attr("y", h*53/150)		.attr("font-size", h*3/200)		.attr("font-family", "sans-serif")		.attr("font-weight", "bold")		.text("living room");			tree.append("text")		.attr("x", w*27/200)		.attr("y", h*23/150)		.attr("font-size", h*3/200)		.attr("font-family", "sans-serif")		.attr("font-weight", "bold")		.text("bedroom");			tree.append("text")		.attr("x", w*148/200)		.attr("y", h*20/150)		.attr("font-size", h*3/200)		.attr("font-family", "sans-serif")		.attr("font-weight", "bold")		.text("bathroom");		tree.append("text")		.attr("x", w*182/200)		.attr("y", h*48/150)		.attr("font-size", h*3/200)		.attr("font-family", "sans-serif")		.attr("font-weight", "bold")		.text("Laundry");	tree.append("text")		.attr("x", w*172/200)		.attr("y", h*91/150)		.attr("font-size", h*3/200)		.attr("font-family", "sans-serif")		.attr("font-weight", "bold")		.text("kitchen");	}function drawMeter() {    meter = svg.append("g").attr("class", "meter");     meter.append("image")        .attr("x", 0)        .attr("y", 0)		.attr("transform", "translate("+w*160/200+","+h*120/150+")")        .attr("width", w*50/200)        .attr("height", h*37/150)        .attr("xlink:href", "./images/Tree/TreeVis_EnergyMeter_Scale.png");			var d = "M 0 0 L "+0.7*w/200 +" 0 L "+0.2*w/200 + " " +(-14*h/150) +" L " +(-0.2*w/150)+ " " + (-14*h/150) + " L " +(-0.7*w/200)+ " 0 L 0 0";    var angle = totalEnergy()*120/maxDayEnergy-60;	pointer = meter.append("path")		.attr("transform", "translate("+w*185.5/200+","+h*143/150+")" + "rotate("+angle+")")        .attr("d", d)        .attr("fill", "#eb2027");}function updateMeter(){	var d = "M 0 0 L "+0.7*w/200 +" 0 L "+0.2*w/200 + " " +(-14*h/150) +" L " +(-0.2*w/150)+ " " + (-14*h/150) + " L " +(-0.7*w/200)+ " 0 L 0 0";    var angle = totalEnergy()*120/maxDayEnergy-60;	pointer.transition()		.duration(500)		.attr("transform", "translate("+w*185.5/200+","+h*143/150+")" + "rotate("+angle+")")        .attr("d", d)        .attr("fill", "#eb2027");	}function drawLeaves() {	leaves = new Array();	for(var i = 0; i < appliances.length; i++){			var x = appliances[i].posx*w/200;// - appliances[i].size*10*w/200/2;		var y = appliances[i].posy*h/150 - appliances[i].size*18*h/150/2;		var scalex = appliances[i].size*w/200;		var scaley = appliances[i].size*h/150;		var leaf = new Leaf(svg, x, y, scalex, scaley, i, appliances[i].icon);		leaves.push(leaf);		leaf.draw();	}}function updateLeaves() {	for(var i = 0; i < leaves.length; i++){		var x = appliances[i].posx*w/200;// - appliances[i].size*10*w/200/2;		var y = appliances[i].posy*h/150 - appliances[i].size*18*h/150/2;		var scalex = appliances[i].size*w/200;		var scaley = appliances[i].size*h/150;		leaves[i].redraw(x, y, scalex, scaley, appliances[i].icon);	}}function drawBerries() {    berryLayer = svg.append("g").attr("class", "berryLayer");     berryLayer.selectAll("image")        .data(berries)        .enter().append("image")        .attr("width", w*6/200)        .attr("height", h*6/150)        .attr("transform", function(d, i){return "translate("+berries[i].x*w/200+","+ berries[i].y*h/150+ ")";})        .attr("xlink:href", function(d, i){return berries[i].image;}); }function updateBerries() {    if(!reset) {        berryLayer.selectAll("image")            .data(berries)            .enter().append("image")            .attr("width", w*6/200)            .attr("height", h*6/150)            .attr("transform", function(d, i){return "translate("+berries[i].x*w/200+","+ berries[i].y*h/150+ ")";})            .attr("xlink:href", function(d, i){return berries[i].image;});    }   else   	    berryLayer.selectAll("image").remove();}function totalEnergy() {    var total = 0;    for(var i = 0; i < appliances.length; i++) {        total = total + Math.floor(appliances[i].energy);    }    return total;}