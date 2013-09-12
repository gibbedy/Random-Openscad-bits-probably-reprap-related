use <..\Bolt.scad>;
//module Bolt(diameter,length,head_size,head_depth)

use <..\Bearing.scad>;

//Simple skid steer rc tank

	//length of cylinder to be used as cutout for other bits
	holeExtension=5;

//Motor dimensions
motorLength=68.3;
motorDiameter=42.8;
motorShaftLength=17;
motorShaftDiameter=5;

//axle Dimensions
axleDiameter=8;
axleLength=200;

wallThickness=5;

//chassis wheel points
	width=motorLength+holeExtension-.0001;
	vehicleLength=200;
	vehicleHeight=55;
	topFrontWheel=[vehicleLength/2,0,0];
	topBackWheel=[-vehicleLength/2,0,0];

function pointPlusWidth(vec3,width)=[vec3[0],width,vec3[2]];
function vec3ToVec2(vec3)=[vec3[0],vec3[2]];

//motor holder
module motorHolder(cutout)
{
	//motor ventilation
	airTubes=4;
	boxHeight=50;
	boxLength=20;
	boxWidth=10;

	//if using for cutout 
	if(cutout)
	{
		translate([0,0,holeExtension/2])
		cylinder(motorLength+holeExtension,motorDiameter/2+wallThickness,motorDiameter/2+wallThickness,true);
	
		//cutout for motor power wiring

	
		translate([0,-motorDiameter/2,-motorLength/2+boxWidth/2])
		cube([boxLength,boxHeight,boxWidth],true);	
	}

	else
	{


		difference()
		{

			translate([0,0,holeExtension/2])
			cylinder(motorLength+holeExtension,motorDiameter/2+wallThickness,motorDiameter/2+wallThickness,true);
	

			for ( i = [0 : 20 : 360] )
			{
				rotate([0,0,i])
				translate([motorDiameter/2,0,0])
				cylinder(motorLength,airTubes/2,airTubes/2,true);
			}
		
			motor();
		}
	}
}

//Motor with geometry to allow mounting holes to be cutout
module motor()
{

	//motor cylinder
	cylinder(motorLength,motorDiameter/2,motorDiameter/2,true);
	
	//Shaft
	translate([0,0,motorLength/2+motorShaftLength/2])
	cylinder(motorShaftLength,motorShaftDiameter/2,motorShaftDiameter/2,true);

	//mounting holes @ 25mm centers 6 holes
	holeDiameter=4;
	holeCenters=25;
	mountingHoles=6;
	

	
	//mounting holes
	for ( i = [0 : mountingHoles] )
	{
   	rotate( i * 360 / mountingHoles,[0, 0, 1])
		translate([holeCenters/2,0,motorLength/2+holeExtension/2])
		cylinder(holeExtension,holeDiameter/2,holeDiameter/2,true);
	}

	//center hole for shaft and possibly gear (used for cutout)
	shaftBaseCutout=15;

	translate([0,0,motorLength/2+holeExtension/2])
	cylinder(holeExtension,shaftBaseCutout/2,shaftBaseCutout/2,true);

	//cutout for motor power wiring
	boxHeight=10;
	boxLength=20;
	boxWidth=10;
	
	translate([0,-motorDiameter/2,-motorLength/2+boxWidth/2])
	cube([boxLength,boxHeight,boxWidth],true);	
}

module axles()
{
	//dimensions for bolt to hold wheels on
	boltLength=55;
	boltDiameter=8;
	boltHeadSize=13;
	

	//set for amount required to hold wheel on.. may parameterise this
	boltOffset=20;

	boltHeadDepth=width-boltLength+boltOffset;

	difference()
	{
		difference()
		{//chassis made from a couple of cylinders minus a couple of cubes
			union()
			{
				translate([topFrontWheel[0]/2,topFrontWheel[1],topFrontWheel[2]])
				rotate([-90,0,0])
				cylinder(width,vehicleLength/3,vehicleLength/3,true);

				translate([topBackWheel[0]/2,topBackWheel[1],topBackWheel[2]])
				rotate([-90,0,0])
				cylinder(width,vehicleLength/3,vehicleLength/3,true);
				

				//translate([0,(motorLength+motorShaftLength)*1.5/2,0])
				//translate(topBackWheel)
				//rotate([-90,0,0])
				//cylinder((motorLength+motorShaftLength)*1.5,vehicleHeight/4,vehicleHeight/4,true);

				//translate([0,(motorLength+motorShaftLength)*1.5/2,0])
				//translate(topFrontWheel)
				//rotate([-90,0,0])
				//cylinder((motorLength+motorShaftLength)*1.5,vehicleHeight/4,vehicleHeight/4,true);

				

			}
			translate([0,holeExtension/2,0])
			rotate([-90,0,180])
			motorHolder(true);

			translate([0,0,vehicleLength/3/2+vehicleHeight/2])
			cube([vehicleLength*2,width+1,vehicleLength/3],true);

			translate([0,0,-(vehicleLength/3/2+vehicleHeight/2)])
			cube([vehicleLength*2,width+1,vehicleLength/3],true);
		

		}

/*
		translate(bottomFrontWheel)
		rotate([-90,0,0])
		cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

		translate(bottomBackWheel)
		rotate([-90,0,0])
		cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);
*/

		translate(topFrontWheel)
		rotate([-90,0,0])
		cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

		translate(topBackWheel)
		rotate([-90,0,0])
		cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);
/*
		translate(frontDriveIdler)
		rotate([-90,0,0])
		cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);


		translate(backDriveIdler)
		rotate([-90,0,0])	
		cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);
*/		

	//bolt for backwheel to go on
	translate(topBackWheel)
	translate([0,boltLength/2+boltHeadDepth/2-(width-boltLength-boltHeadDepth)/2 -boltOffset,0])
	rotate([90,0,0])
	Bolt(boltDiameter,boltLength,boltHeadSize,boltHeadDepth);

	//bolt for front wheel to go on
	translate(topFrontWheel)
	translate([0,boltLength/2+boltHeadDepth/2-(width-boltLength-boltHeadDepth)/2 -boltOffset,0])
	rotate([90,0,0])
	Bolt(boltDiameter,boltLength,boltHeadSize,boltHeadDepth);


	}
	translate([0,holeExtension/2,0])
	rotate([-90,0,180])
	motorHolder();





}

//motor spacing off center
//difference()
{
//translate([0,-motorLength*1.5-wallThickness,0])
//chassis();

//translate([0,-motorLength,0])
//rotate([-90,0,180])
//{
//motorHolder(true);
//}
//}

//difference()
//{

//translate([0,-(motorLength/2+motorLength-width/2+wallThickness),0])
axles();
//motorHolder();
//translate([0,-motorLength,0])
//rotate([-90,0,180])
{
//motorHolder(true);
}
}
//translate([0,-motorLength,0])

				

		
