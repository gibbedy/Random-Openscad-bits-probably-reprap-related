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
screwDiameter=3;

//nutSize is diameter of nut face. 
nutSize=6;
nutHeight=4;

grubScrewDiameter=3;
//4 size shim thing
module shimKit()
{

	difference()
	{
	union()
	{
	translate([0,0,.1/2])
	shim(.1);

	translate([mountDiameter*2,0,.2/2])
	shim(.2);

	translate([mountDiameter*4,0,.3/2])
	shim(.3);

	translate([mountDiameter*6,0,.4/2])
	shim(.4);

	translate([0,mountDiameter*2,.5/2])
	shim(.5);

	translate([mountDiameter*2,mountDiameter*2,.6/2])
	shim(.6);

	translate([mountDiameter*4,mountDiameter*2,.7/2])
	shim(.7);

	translate([mountDiameter*6,mountDiameter*2,.8/2])
	shim(.8);
	}
	}

}

//shim for adjusting level
module shim(shimHeight)
{
	difference()
	{
	union()
	{
	//main bit
	#cylinder(shimHeight,mountDiameter,mountDiameter,true);
	}
	//slot in shim
	cylinder(shimHeight,screwDiameter/2,screwDiameter/2,true);
	translate([mountDiameter/2,0,0])
	cube([mountDiameter,screwDiameter,shimHeight],true);
	}
	
}
module FC()
{
	translate([0,0,FCHeight/2+wallThickness])
	cube([FCLength,FCWidth,FCHeight],true);
}

//nut holder to make adjustment easier
module bottomPlate()
{

	difference()
	{
	union()
	{
	translate([-wallThickness/2,0,(wallThickness)/4])
	cube([FCLength+wallThickness,FCWidth+2*wallThickness,wallThickness/2],true);
	
	//mounting hole bits
	translate([mountingHoleCenters/2,mountingHoleCenters/2,wallThickness/4])
	{
		cylinder(wallThickness/2,mountDiameter/2,mountDiameter/2,true);
		translate([0,0,-(nutHeight+wallThickness/2)/2])
		grubScrewTab();
	}
		

	translate([-mountingHoleCenters/2,mountingHoleCenters/2,wallThickness/4])
	{
		cylinder(wallThickness/2,mountDiameter/2,mountDiameter/2,true);
		translate([0,0,-(nutHeight+wallThickness/2)/2])
		grubScrewTab();
	}

	translate([-mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/4])
	{
		cylinder(wallThickness/2,mountDiameter/2,mountDiameter/2,true);
		translate([0,0,-(nutHeight+wallThickness/2)/2])
		grubScrewTab();
	}

	translate([mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/4])
	{
		cylinder(wallThickness/2,mountDiameter/2,mountDiameter/2,true);
		translate([0,0,-(nutHeight+wallThickness/2)/2])
		grubScrewTab();
	}


	}//end union

	//minus screw holes
	translate([mountingHoleCenters/2,mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);
	
	translate([-mountingHoleCenters/2,mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);

	translate([-mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);

	translate([mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);


	}//end difference

}

module mountingPlate()
{
	difference()
	{
	union()
	{
	//baseplate minus corner bits
	translate([-wallThickness/2,0,(nutHeight+wallThickness)/2])
	cube([FCLength+wallThickness,FCWidth+2*wallThickness,nutHeight+wallThickness],true);
	
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
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);
	
	translate([-mountingHoleCenters/2,mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);

	translate([-mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);

	translate([mountingHoleCenters/2,-mountingHoleCenters/2,wallThickness/2])
	#cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);
	}

}

difference()
{
//mountingPlate();
///FC();
}

//translate([0,50,wallThickness/2])
rotate([180,0,0])
bottomPlate();

//translate([50,0,0])

//shimKit();

module grubScrewTab()
{
difference()
{
nut(nutSize*2,nutHeight+wallThickness);

//nut cutout
//translate([0,0,-(wallThickness)/2])
//#nut(nutSize,nutHeight);

//grubScrewHole cutout
//leave geometry for bridge to be removed after print
//translate([0,0,FCHeight/2+layerHeight])
//#cylinder(FCHeight,grubScrewDiameter/2,grubScrewDiameter/2,true);

//translate([0,0,FCHeight/2+layerHeight])
#cylinder(nutHeight+wallThickness,grubScrewDiameter/2,grubScrewDiameter/2,true);
}
}