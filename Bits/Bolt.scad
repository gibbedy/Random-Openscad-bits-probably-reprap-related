//This is my attempt to model a bolt.


//Create a bolt by specifying shaft diameter, shaft length, distance accross head flats, and depth of head
module Bolt(diameter,length,head_size,head_depth)
	{
	echo("********************************************");
	echo("Creating bolt with following dimensions");
	echo("Diameter: ",diameter);
	echo("Shaft length: ",length);
	echo("Head size (between flats): ",head_size);
	echo("Head depth: ",head_depth);
	echo("********************************************");

	//Calculate dimentions of hexagon for head of bolt based on distance
	//between flats

	//google found..
	//side_length= 2a tan (180/n)
	//a  is the length of the apothem (inradius)
	//n  is the number of sides
	//tan  is the tangent function calculated in degrees
   side_length=2*head_size/2* tan(180/6);

	//create hexagonal head from 3 cubes rotated 120 degrees
	translate([-side_length/2,-head_size/2,0]) cube([side_length,head_size,head_depth]);
	rotate([0,0,120]) translate([-side_length/2,-head_size/2,0])cube([side_length,head_size,head_depth]);
	rotate([0,0,240]) translate([-side_length/2,-head_size/2,0])cube([side_length,head_size,head_depth]);
	
	//Add shaft offset by depth of head
	shaft_radius=diameter/2;
	translate([0,0,head_depth]) cylinder(length,shaft_radius,shaft_radius);
	}

//Parameters ***********************************
//diameter of shaft
diameter=8;

//length of shaft
length=50;

//distance between flats of head
head_size=13;

//depth of head
head_depth=4.8;

//**********************************************

Bolt(diameter,length,head_size,head_depth);




