//Hi I am Gibbedy :)
//This is my attempt to model an M8 bolt.
//In an effort to learn openscad and github I would like anyone 
//to simplify my code. Or just make changes for the sake of it so I can see
//how this github thing works.

module Bolt_50_mm_M8()
	{
	translate(0,0,4.8) cylinder(50,4,4);
	translate([-3.75,-6.5,0])cube([7.5,13,4.8]);
	rotate([0,0,120]) translate([-3.75,-6.5,0])cube([7.5,13,4.8]);
	rotate([0,0,240]) translate([-3.75,-6.5,0])cube([7.5,13,4.8]);
	}

Bolt_50_mm_M8();

//
