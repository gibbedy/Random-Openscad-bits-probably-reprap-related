//Simple skid steer rc tank

//Motor dimensions
motorLength=68.3;
motorDiameter=42.8;
motorShaftLength=17;
motorShaftDiameter=5;

//axle Dimensions
axleDiameter=8;
axleLength=55;

wallThickness=5;
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
	
	//length of cylinder to be used as cutout for other bits
	holeExtension=5;
	
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

	
	translate([100,0,-50])
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate([-100,0,-50])
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate([150,0,0])
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate([-150,0,0])
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate([50,0,0])
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate([-50,0,0])
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

}

//motor spacing off center
translate([0,motorLength,0])
rotate([-90,0,0])
motor();

translate([0,motorLength/2+motorLength-axleLength/2+wallThickness,0])
axles();

