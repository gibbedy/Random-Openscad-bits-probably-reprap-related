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

//chassis wheel points
	width=30;

	bottomFrontWheel=[100,0,-50];
	bottomFrontWheel2=pointPlusWidth(bottomFrontWheel,width);
	bottomBackWheel=[-100,0,-50];
	bottomBackWheel2=pointPlusWidth(bottomBackWheel,width);
	topFrontWheel=[150,0,0];
	topFrontWheel2=pointPlusWidth(topFrontWheel,width);
	topBackWheel=[-150,0,0];
	topBackWheel2=pointPlusWidth(topBackWheel,width);
	frontDriveIdler=[50,0,0];
	frontDriveIdler2=pointPlusWidth(frontDriveIdler,width);
	backDriveIdler=[-50,0,0];
	backDriveIdler2=pointPlusWidth(backDriveIdler,width);

function pointPlusWidth(vec3,width)=[vec3[0],width,vec3[2]];
function vec3ToVec2(vec3)=[vec3[0],vec3[2]];

//chassis
module chassis()
{

	polyhedron(
  points=[ bottomFrontWheel,bottomFrontWheel2,topFrontWheel,topFrontWheel2, 
           frontDriveIdler,frontDriveIdler2,backDriveIdler,backDriveIdler2,topBackWheel,
			topBackWheel2,bottomBackWheel,bottomBackWheel2],                                 
  triangles=[ [0,2,1],[1,2,3],[2,4,3],[3,4,5],          
              [4,6,5],[5,6,7],[6,8,7],[7,8,9],
				  [8,10,9],[9,10,11],[10,0,11],
					[11,0,1],
					[0,4,2],[0,6,4],[0,8,6],[0,10,8],
					[1,3,5],[1,5,7],[1,7,9],[1,9,11]]);
	

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


	translate(bottomFrontWheel)
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate(bottomBackWheel)
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate(topFrontWheel)
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate(topBackWheel)
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate(frontDriveIdler)
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

	translate(backDriveIdler)
	rotate([-90,0,0])
	cylinder(axleLength,axleDiameter/2,axleDiameter/2,true);

}

//motor spacing off center
//translate([0,motorLength,0])
//rotate([-90,0,0])
//motor();

//translate([0,motorLength/2+motorLength-axleLength/2+wallThickness,0])
//axles();
difference()
{
chassis();
motor();
}
