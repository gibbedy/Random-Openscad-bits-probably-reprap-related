//this is a tool to hold the motor on my 
//Hornet 460 quadcopter for changing props.

locatorHeight=3;
locatorDiameter=5;
motorShaftDiameter=11.5;
wallThickness=3;
handleLength=100;

$fn=50;
difference()
{
union()
{
//locators
translate([motorShaftDiameter/2+locatorDiameter/2,0,locatorHeight/2+wallThickness])
cylinder(locatorHeight,locatorDiameter/2,locatorDiameter/2,true);

rotate([0,0,72])
translate([motorShaftDiameter/2+locatorDiameter/2,0,locatorHeight/2+wallThickness])
cylinder(locatorHeight,locatorDiameter/2,locatorDiameter/2,true);

rotate([0,0,144])
translate([motorShaftDiameter/2+locatorDiameter/2,0,locatorHeight/2+wallThickness])
cylinder(locatorHeight,locatorDiameter/2,locatorDiameter/2,true);

rotate([0,0,216])
translate([motorShaftDiameter/2+locatorDiameter/2,0,locatorHeight/2+wallThickness])
cylinder(locatorHeight,locatorDiameter/2,locatorDiameter/2,true);

rotate([0,0,288])
translate([motorShaftDiameter/2+locatorDiameter/2,0,locatorHeight/2+wallThickness])
cylinder(locatorHeight,locatorDiameter/2,locatorDiameter/2,true);

//handle and round base
translate([0,0,wallThickness/2])
{
	cylinder(wallThickness,motorShaftDiameter/2+locatorDiameter,motorShaftDiameter/2+locatorDiameter,true);
	translate([handleLength/2,0,0])
	cube([handleLength,motorShaftDiameter/2+locatorDiameter,wallThickness],true);

//round end for spanner
	translate([handleLength,0,0])
	#cylinder(wallThickness,(motorShaftDiameter/2+locatorDiameter)/2,(motorShaftDiameter/2+locatorDiameter)/2,true);
}
}
//minuse slot so it can be put on motor shaft
rotate([0,0,72/2])
{
translate([0,0,(locatorHeight+wallThickness)/2])
{
	cylinder(locatorHeight+wallThickness,motorShaftDiameter/2,motorShaftDiameter/2,true);
	translate([-(motorShaftDiameter/2+locatorDiameter)/2,0,0])
	cube([motorShaftDiameter/2+locatorDiameter,motorShaftDiameter,locatorHeight+wallThickness],true);
}
}
}