//This is my attempt to model a bearing.


//Create a bearing by specifying internal diameter, external diameter and width.
module bearing(ext_Diameter,int_Diameter,width)
	{
	echo("********************************************");
	echo("Creating bearing with following dimensions");
	echo("Internal Diameter: ",int_Diameter);
	echo("External Diameter: ",ext_Diameter);
	echo("Width: ",width);
	echo("********************************************");



	//create external cylinder minus internal cylinder
	difference()
		{
		bearingExternalGeom(ext_Diameter,width);
		cylinder(width,int_Diameter/2,int_Diameter/2,true);
		}
	


//	translate([-side_length/2,-head_size/2,0]) cube([side_length,head_size,head_depth]);
	//rotate([0,0,120]) translate([-side_length/2,-head_size/2,0])cube([side_length,head_size,head_depth]);
	//rotate([0,0,240]) translate([-side_length/2,-head_size/2,0])cube([side_length,head_size,head_depth]);
	
	//Add shaft offset by depth of head
	//shaft_radius=diameter/2;
//	translate([0,0,head_depth]) cylinder(length,shaft_radius,shaft_radius);
	}

//use for getting external geometry only (for binary commands)
module bearingExternalGeom(ext_Diameter,width)
	{
	echo("********************************************");
	echo("Creating bearing (external geometry) with following dimensions");
	echo("External Diameter: ",ext_Diameter);
	echo("Width: ",width);
	echo("********************************************");
	cylinder(width,ext_Diameter/2,ext_Diameter/2,true);
	
	}

//Parameters ***********************************
//Internal diameter
int_Diameter=4;

//External Diameter
ext_Diameter=13;

//width
width=5;

//608=8,22,7
//624=4,13,5
//**********************************************

bearing(ext_Diameter,int_Diameter,width);

//used to provide usage info 
module Bearing_Info()
{
	echo("Usage: bearing(External Diameter, Internal Diameter, Width)");
	echo("       bearingExternalGeom(External Diameter,Width)");
}



