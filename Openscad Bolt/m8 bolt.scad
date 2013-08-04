//Hi I am Gibbedy :)
//This is my attempt to model an M8 bolt.
//In an effort to learn openscad and github I would like anyone 
//to simplify my code. Or just make changes for the sake of it so I can see
//how this github thing works.

module Bolt_50_mm_M8(diameter,length,head_size,head_depth)
	{
echo("diameter: ",diameter," length: ",length," head_size: ",head_size," head_depth: ",head_depth);

//Calculate dimentions of hexagon for head of bolt based on distance
//between flats

	//google found..
	//side_length= 2a tan (180/n)
	//a  is the length of the apothem (inradius)
	//n  is the number of sides
	//tan  is the tangent function calculated in degrees
   side_length=2*head_size/2* tan(180/6);

   echo("side_length",side_length);
   echo(-side_length/2,-head_size/2,side_length,head_size,head_depth);
	translate([-side_length/2,-head_size/2,0]) cube([side_length,head_size,head_depth]);
	rotate([0,0,120]) translate([-side_length/2,-head_size/2,0])cube([side_length,head_size,head_depth]);
	rotate([0,0,240]) translate([-side_length/2,-head_size/2,0])cube([side_length,head_size,head_depth]);

	shaft_radius=diameter/2;
	translate(0,0,head_depth) cylinder(length,shaft_radius,shaft_radius);
	}
//diameter of shaft
diameter=8;

//length of shaft
length=50;

//distance between flats of head
head_size=13;

//depth of head
head_depth=4.8;

Bolt_50_mm_M8(diameter,length,head_size,head_depth);


