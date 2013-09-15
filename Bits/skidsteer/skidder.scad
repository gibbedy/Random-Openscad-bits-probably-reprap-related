use <..\Bearing.scad>;
use <..\Bolt.scad>;

//$fn=100;
//layer height used
layerHeight=.3;
//module Bolt(diameter,length,head_size,head_depth)

	//dimensions for bolt to hold wheels on
	boltLength=55;
	boltDiameter=8.5;
	boltHeadSize=13.25;
	

	//set for amount required to hold wheel on.. may parameterise this
	boltOffset=20;






//Simple skid steer rc tank

	//length of cylinder to be used as cutout for other bits
	holeExtension=5;

//Motor dimensions
motorLength=68.3;
motorDiameter=44;
motorShaftLength=17;
motorShaftDiameter=5.5;


wallThickness=5;

//chassis wheel points
   //width=motorLength+holeExtension-.0001;
	width=wallThickness;
	vehicleLength=150;
	vehicleHeight=55;
	topFrontWheel=[vehicleLength/2,0,0];
	topBackWheel=[-vehicleLength/2,0,0];

	boltHeadDepth=width-boltLength+boltOffset;


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
		translate([0,0,width/2])
		cylinder(motorLength+width,motorDiameter/2+wallThickness,motorDiameter/2+wallThickness,true);
	
		//cutout for motor power wiring

	
		translate([0,-motorDiameter/2,-motorLength/2+boxWidth/2])
		cube([boxLength,boxHeight,boxWidth],true);	
	}

	else
	{


		difference()
		{

			translate([0,0,width/2])
			//full length motor holder has been commented for now
			//cylinder(motorLength+width,motorDiameter/2+wallThickness,motorDiameter/2+wallThickness,true);
		
			//and replaced with the following two lines
			translate([0,0,(motorLength+width)/2-(width*3)/2])
			cylinder(width*3,motorDiameter/2+wallThickness,motorDiameter/2+wallThickness,true);
			//

			//ribbs for air flow and ease of motor installation
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
	//how far to countersink screw
	screwHeadDepth=3;
	screwHeadDiameter=6;
	
	//mounting holes
	for ( i = [0 : mountingHoles] )
	{
   	rotate( i * 360 / mountingHoles,[0, 0, 1])
		translate([holeCenters/2,0,motorLength/2])
		{
			cylinder(width-screwHeadDepth,holeDiameter/2,holeDiameter/2);
			//bit to countersink screw
			//layerHeight used here to provide bridge for screw hole support
			translate([0,0,width-screwHeadDepth+layerHeight])
			cylinder(screwHeadDepth,screwHeadDiameter/2,screwHeadDiameter/2);
		}
	}

	//center hole for shaft and possibly gear (used for cutout)
	shaftBaseCutout=15;

	translate([0,0,motorLength/2+width/2])
	cylinder(width,shaftBaseCutout/2,shaftBaseCutout/2,true);

	//cutout for motor power wiring
	boxHeight=10;
	boxLength=20;
	boxWidth=10;
	
	translate([0,-motorDiameter/2,-motorLength/2+boxWidth/2])
	cube([boxLength,boxHeight,boxWidth],true);	
}

//main body of vehicle
module chassisMain()
{

		difference()
		{//chassis made from a couple of cylinders minus a couple of cubes

			difference()
			{
				intersection()
				{
					cube([vehicleLength*2,vehicleLength,vehicleHeight+2*wallThickness],true);
					union()
					{
						translate([topFrontWheel[0]/2,topFrontWheel[1],topFrontWheel[2]])
						rotate([-90,0,0])
						cylinder(vehicleLength,vehicleLength/3,vehicleLength/3,true);

						translate([topBackWheel[0]/2,topBackWheel[1],topBackWheel[2]])
						rotate([-90,0,0])
						cylinder(vehicleLength,vehicleLength/3,vehicleLength/3,true);

					}
				}
			}

			
			intersection()
			{
				cube([vehicleLength*2,vehicleLength+.0001,vehicleHeight],true);
				union()
				{
					translate([topFrontWheel[0]/3,topFrontWheel[1],topFrontWheel[2]])
					rotate([-90,0,0])
					cylinder(vehicleLength+.0001,vehicleLength/2.7,vehicleLength/2.7,true);

					translate([topBackWheel[0]/3,topBackWheel[1],topBackWheel[2]])
					rotate([-90,0,0])
					cylinder(vehicleLength+.0001,vehicleLength/2.7,vehicleLength/2.7,true);

				}
			}
			
			
		}//END chassis made from a couple of cylinders minus a couple of cubes


		difference()
		{
			//shaft for backwheel to go on
			translate(topBackWheel)
			rotate([90,0,0])
			cylinder(vehicleLength,boltDiameter,boltDiameter,true);
		
			translate(topBackWheel)
			rotate([90,0,0])
			cylinder(vehicleLength,boltDiameter/2,boltDiameter/2,true);
		}

		difference()
		{
			//shaft for front wheel to go on
			translate(topFrontWheel)
			rotate([90,0,0])
			cylinder(vehicleLength,boltDiameter,boltDiameter,true);
		
			translate(topFrontWheel)
			rotate([90,0,0])
			cylinder(vehicleLength,boltDiameter/2,boltDiameter/2,true);
		}


	

}
module axles()
{


	difference()
	{
		difference()
		{//chassis made from a couple of cylinders minus a couple of cubes
			union()
			{
				intersection()
				{
					cube([vehicleLength*2,width,vehicleHeight],true);
					union()
					{
						translate([topFrontWheel[0]/2,topFrontWheel[1],topFrontWheel[2]])
						rotate([-90,0,0])
						cylinder(width,vehicleLength/3,vehicleLength/3,true);

						translate([topBackWheel[0]/2,topBackWheel[1],topBackWheel[2]])
						rotate([-90,0,0])	
						cylinder(width,vehicleLength/3,vehicleLength/3,true);

					}
				}
			//support to keep axle square LHS
			translate([topBackWheel[0],topBackWheel[1]-width/2,topBackWheel[2]])
			rotate([-90,0,0])
			cylinder(width*3,boltDiameter,boltDiameter);

			//support to keep axle square RHS
			translate([topFrontWheel[0],topFrontWheel[1]-width/2,topFrontWheel[2]])
			rotate([-90,0,0])
			cylinder(width*3,boltDiameter,boltDiameter);
			}

			//cutout for motor holder
			translate([0,holeExtension/2,0])
			rotate([-90,0,180])
			motorHolder(true);
			


			//cutout to save on plastic
			translate([topFrontWheel[0]/2,topFrontWheel[1],topFrontWheel[2]])
			rotate([-90,0,0])
			cylinder(width,
			min(vehicleHeight/2-wallThickness,(
			topFrontWheel[0]-boltDiameter/2-motorDiameter/2-wallThickness*3)/2),
			min(vehicleHeight/2-wallThickness,
			(topFrontWheel[0]-boltDiameter/2-motorDiameter/2-wallThickness*3)/2),true);


			//cutout to save on plastic
			translate([topBackWheel[0]/2,topBackWheel[1],topBackWheel[2]])
			rotate([-90,0,0])
			cylinder(width,
			min(vehicleHeight/2-wallThickness,(
			-topBackWheel[0]-boltDiameter/2-motorDiameter/2-wallThickness*3)/2),
			min(vehicleHeight/2-wallThickness,
			(-topBackWheel[0]-boltDiameter/2-motorDiameter/2-wallThickness*3)/2),true);
		}

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



	translate([0,(motorLength+holeExtension-width)/2+holeExtension/2,0])
	rotate([-90,0,180])
	motorHolder();
}

//motor spacing off center
//difference()

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
//rotate([90,0,0])
//axles();
//motorHolder();
//translate([0,-motorLength,0])
//rotate([-90,0,180])
//chassisMain();
//motorHolder(true);
//chassisBase();
//chassisLid();

//translate([0,-motorLength,0])

module chassisBase()
{
	difference()
	{
	
		chassisMain();		
		translate([topBackWheel[0],topBackWheel[1],topBackWheel[2]+vehicleHeight/2])
		{
			rotate([90,0,0])
			cylinder(vehicleLength*3/4,(vehicleHeight+boltDiameter*2)/2+4,(vehicleHeight+boltDiameter*2)/2+4,true);
			//cube([vehicleLength/2,3/4*vehicleLength,vehicleHeight+boltDiameter*2],true);
			cube([vehicleLength*3,3/4*vehicleLength,vehicleHeight-boltDiameter*2],true);
		}
		
	}
}

module chassisLid()
{
	intersection()
	{
	
		chassisMain();		
		translate([topBackWheel[0],topBackWheel[1],topBackWheel[2]+vehicleHeight/2])
		{
			rotate([90,0,0])
			cylinder(vehicleLength*3/4,(vehicleHeight+boltDiameter*2)/2,(vehicleHeight+boltDiameter*2)/2,true);
			//cube([vehicleLength/2,3/4*vehicleLength,vehicleHeight+boltDiameter*2],true);
			cube([vehicleLength*3,3/4*vehicleLength,vehicleHeight-boltDiameter*2],true);
		}
		
	}

}
module bigGear()
{
		//number of holes to cutout to save printing time
		numberOfHoles=6;

	difference()
	{
		union()
		{
			translate([0,0,wallThickness/2])
			linear_extrude(height=wallThickness,center=true,convexity=10)
			import (file = "bigGear.dxf");

			//bearing holder
			cylinder(8,14,14);
		}

		//bearing cutout
		translate([0,0,7/2+8-7])
		bearingExternalGeom(22.5,7);
	
		//axle cutout
		cylinder(8,(22.5-2)/2,(22.5-2)/2);



		for ( i = [0 : numberOfHoles] )
		{
   		rotate( i * 360 / numberOfHoles,[0, 0, 1])
			translate([35,0,0])
			cylinder(20,15,15,true);
		}
	}

	//1.5mm washer for gear
	difference()
	{
		union()
		{
			//top bit
			cylinder(1.5,(boltDiameter+3)/2,(boltDiameter+3)/2);
			//bottom bit
			cylinder(1,(22.5-3)/2,(22.5-3)/2);
		}
		cylinder(1.5,boltDiameter/2,boltDiameter/2);
	}
}


module littleGear()
{
	difference()
	{
		union()
		{
			//import gear geometry from gearotic
			translate([0,0,wallThickness/2])
			linear_extrude(height=wallThickness,center=true,convexity=10)
			import (file = "pinion-2D2.dxf");
	
			//cylinder for meat of gear	
			cylinder(motorShaftLength-wallThickness,15/2,15/2);
	
			translate([0,8/2,(motorShaftLength-wallThickness)/2])
			cube([15,8,motorShaftLength-wallThickness],true);
		}

		//shaft for cutout
		difference()
		{
			//-wallThickness because of motor offset position
			cylinder(motorShaftLength-wallThickness,motorShaftDiameter/2,motorShaftDiameter/2);
			//sqare shaft
			translate([0,motorShaftDiameter/2,motorShaftLength/2])
			cube([motorShaftDiameter,1,motorShaftLength],true);
		}
	
		//3mm nut cutout
		translate([0,motorShaftDiameter/2+3/2-1,wallThickness+3])
		{
			//cube to make shaft to insert grub screw nut
			translate([0,0,10/2])
			cube([7,3,10],true);
			//cylinder for meat of gear
			rotate([90,0,0])
			{
				nut(6,3);
			translate([0,0,-20/2])
			cylinder(20,1.75,1.75,true);
			}
		}
	}
}


/*
//put it together for viewing
//front Right big gear
translate([0,(-vehicleLength/2),0])
translate(topFrontWheel)
rotate([90,0,0])
bigGear();

//back right big gear
translate([0,(-vehicleLength/2),0])
translate(topBackWheel)
rotate([90,0,0])
bigGear();

//front Left big gear
translate([0,(vehicleLength/2),0])
translate(topFrontWheel)
rotate([-90,0,0])
bigGear();

//back left big gear
translate([0,(vehicleLength/2),0])
translate(topBackWheel)
rotate([-90,0,0])
bigGear();


//Right little drive gear
translate([0,(-vehicleLength/2),0])
rotate([90,0,0])
littleGear();


//left little drive gear
translate([0,(vehicleLength/2),0])
rotate([-90,0,0])
littleGear();

//Right side 
translate([0,-(vehicleLength/2-width/2),0])

axles();

//Left side
translate([0,(vehicleLength/2-width/2),0])
rotate([0,0,180])
axles();

//lid
translate([-vehicleLength/2,0,vehicleLength/2])
rotate([0,-90,0])
chassisLid();

//motor RHS
translate([0,-(vehicleLength/2-motorLength/2-width),0])
rotate([90,180,0])
motor();

//motor LHS
translate([0,(vehicleLength/2-motorLength/2-width),0])
rotate([-90,0,0])
motor();
*/

//chassisBase();
//bigGear();
//rotate([90,0,0])
//axles();
//motor();
//motorHolder();
tankTrack();

module tankTrack()
{
	//used to experiment to get max strength with minimal plastic
	wallThickness=5;

	rollerDiameter=5;
	rollerWidth=20;
	pitch=20;
	sprocketThickness=rollerWidth-1;
	padWidth=rollerWidth+wallThickness*2;

	//first Roller
	cylinder(rollerWidth,rollerDiameter/2,rollerDiameter/2,true);

	//second roller (part of next link) not sure what i'm doing yet
	translate([pitch,0,0])
	difference()
	{
		cylinder(padWidth,rollerDiameter/2,rollerDiameter/2,true);
		cylinder(rollerWidth,rollerDiameter/2,rollerDiameter/2,true);
	}
	
	//main part of pad
	difference()
	{
		translate([pitch/2,0,0])
		cube([pitch,rollerDiameter,padWidth],true);
	
		//minus bit to allow links to flex
		difference()
		{
			cube([rollerDiameter,rollerDiameter,padWidth],true);

		}
	}

}//end module tankTrack

