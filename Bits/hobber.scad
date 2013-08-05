//Hobbed bolt hobber thingy.
//Needs to hold the bolt and m4 tap securely in position.

use <Bolt.scad>;
use <Bearing.scad>;
use <Tap.scad>;

//main frame of tool
module frame(length,width,height)
	{
	difference()
		{

		//cube for frame
		translate([-width/2,-length/2,-height/2])cube([length,width,height]);

		//lhs bolt bearing
		translate([-width/2,0,0])rotate([0,90,0])boltBearing();
	
		//rhs bolt bearing
		translate([width/2-7,0,0])rotate([0,90,0])boltBearing();
		
		//bolt shaft
		translate([-width/2,0,0])rotate([0,90,0])cylinder(width,4,4);

		//tap front bearing
		translate([0,-width/2+5,4])rotate([90,0,0])tapBearing();

		//tap back bearing
		translate([0,width/2-5,4])rotate([270,0,0])tapBearing();

		//tap shaft
		translate([0,width/2,4])rotate([90,0,0])cylinder(width,2,2);
		}
		
	}

module tapBearing()
	{
	Bearing(4,13,5);
	}

module boltBearing()
	{
	intDiameter=8;
	extDiameter=22;
	width=7;
	bearingExternalGeom(extDiameter,width);
	}

module tapBearing()
	{
	intDiameter=4;
	extDiameter=13;
	width=5;
	bearingExternalGeom(extDiameter,width);
	}

module M4Tap()
	{
	diameter=4;
	sqrSize=3.1;
	sqrLength=8;
	shankLength=23;
	threadLength=24;
	Tap(diameter,sqrSize,sqrLength,shankLength,threadLength);
	}

//Parameters ***********************************
//frame length
length=35;

//frame width
width=35;

//frame height
height=45;

//**********************************************
frame(length,width,height);
translate([0,-length/2-20,4])rotate([270,0,0]) M4Tap();




