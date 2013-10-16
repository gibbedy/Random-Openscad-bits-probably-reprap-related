use <..\Bolt.scad>;
//This is an adjustable mount for my flight controller for my Hornet 460

$fn=50;
//set to layer height used when printing
layerHeight=.3;
//Flight Controller dimensions
FCLength=35;
FCWidth=26.5;
FCHeight=10.5;

wallThickness=2;

mountingHoleCenters=30;
mountDiameter=10;
screwDiameter=3.5;

//nutSize is diameter of nut face. 
nutSize=6;
nutHeight=4;

grubScrewDiameter=3.5;

module FC()
{
	translate([0,0,FCHeight/2+wallThickness])
	cube([FCLength,FCWidth,FCHeight],true);
}

module mountingPlate()
{
	difference()
	{
	union()
	{
	//baseplate minus corner bits
	translate([-wallThickness/2,0,FCHeight/4])
	cube([FCLength+wallThickness,FCWidth+2*wallThickness,FCHeight/2],true);
	
	//mounting hole bits
	translate([mountingHoleCenters/2,mountingHoleCenters/2,wallThickness/2])
	cylinder(wallThickness,mountDiameter/2,mountDiameter/2,true);

	translate([-mountingHoleCenters/2,mountingHoleCenters/2,wallThickness/2])
	cylinder(wallThickness,mountDiameter/2,mountDiameter/2,true);

	translate([-mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/2])
	cylinder(wallThickness,mountDiameter/2,mountDiameter/2,true);

	translate([mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/2])
	cylinder(wallThickness,mountDiameter/2,mountDiameter/2,true);

	}
	//minus corner bits
	translate([-(FCLength+wallThickness)/2,(FCWidth+2*wallThickness)/2,FCHeight/4+wallThickness])
	cube([20,20,FCHeight/2],true);

	translate([-(FCLength+wallThickness)/2,-(FCWidth+2*wallThickness)/2,FCHeight/4+wallThickness])
	cube([20,20,FCHeight/2],true);

	translate([(FCLength+wallThickness)/2,(FCWidth+2*wallThickness)/2,FCHeight/4+wallThickness])
	cube([20,20,FCHeight/2],true);

	translate([(FCLength+wallThickness)/2,-(FCWidth+2*wallThickness)/2,FCHeight/4+wallThickness])
	cube([20,20,FCHeight/2],true);

	//minus screw holes
	translate([mountingHoleCenters/2,mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2-.5,true);
	
	translate([-mountingHoleCenters/2,mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2-.5,true);

	translate([-mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2-.5,true);

	translate([mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2-.5,true);
	}

	//grub screw nut geometry
	translate([((FCLength+wallThickness)/2-nutSize*2),
							((FCWidth+2*wallThickness)/2+nutSize-wallThickness),
							(nutHeight+wallThickness)/2])
	grubScrewTab();

	//grub screw nut geometry
	translate([((FCLength+wallThickness)/2-nutSize*2),
						-((FCWidth+2*wallThickness)/2+nutSize-wallThickness),
						(nutHeight+wallThickness)/2])
	grubScrewTab();

	//grub screw nut geometry
	translate([-(FCLength/2+wallThickness+nutSize/2),
						0,
						(nutHeight+wallThickness)/2])
	rotate([0,0,90])
	grubScrewTab();





}

difference()
{
mountingPlate();
FC();
}


module grubScrewTab()
{
difference()
{
nut(nutSize*2,nutHeight+wallThickness);

//nut cutout
translate([0,0,-(nutHeight)/2])
#nut(nutSize,nutHeight);

//grubScrewHole cutout
//leave geometry for bridge to be removed after print
translate([0,0,FCHeight/2+layerHeight])
cylinder(FCHeight,grubScrewDiameter/2,grubScrewDiameter/2,true);
}
}