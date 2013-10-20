//z axis mount

$fn=50;
holeSpacing=19;
height=10;
wallThickness=3;
screwDiameter=3;

cylinderHeight=15;
//mounting plate
difference()
	{
		union()
		{
			//plate
			cube([wallThickness,holeSpacing+2*wallThickness,height],true);
		
			//cylinders to allow adjustment
			translate([-(wallThickness/2+wallThickness/2),holeSpacing/2+screwDiameter,0])
			cylinder(cylinderHeight,wallThickness,wallThickness,true);
		}
	//screw holes
	translate([0,holeSpacing/2,0])
	rotate([0,90,0])
	cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);

	//screw holes
	translate([0,-holeSpacing/2,0])
	rotate([0,90,0])
	cylinder(wallThickness,screwDiameter/2,screwDiameter/2,true);



}