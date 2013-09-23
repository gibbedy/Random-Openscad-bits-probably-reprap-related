use <..\Bearing.scad>;
use <..\Bolt.scad>;
//Simple skid steer rc tank
//$fn=100;


//thickness of plastic used to hold bearing onto gear/pulley.
bearingLip=1;
//width of side
strength=10;

//pulley and gear dimenstions
bigPulleyDiameter=71.1486;
littlePulleyDiameter=50.1274;

//set to that of pitch Diameter of gear created in dxf file
pinionGearDiameter=30;
//gear must be created with this diameter in dxf
wheelGearDiameter=50 ;

pinionGearDXF="30mmGear.dxf";
wheelGearDXF="50mmGear.dxf";
littlePulleyDXF="50-1274mmPulley.dxf";
bigPulleyDXF="71-1486mmPulley.dxf";


//layer height used
layerHeight=.3;
//module Bolt(diameter,length,head_size,head_depth)

//dimensions for bolt to hold wheels on
boltLength=55;
boltDiameter=8.5;
boltHeadSize=13.25;
	

//set for amount required to hold wheel on.. may parameterise this
boltOffset=20;

//length of cylinder to be used as cutout for other bits
holeExtension=5;

//Motor dimensions
motorLength=68.3;
motorDiameter=44;
motorShaftLength=17;
motorShaftDiameter=5.5;


wallThickness=5;
rideHeight=5;
//chassis wheel points
//width=motorLength+holeExtension-.0001;
width=wallThickness;
vehicleLength=150;
vehicleHeight=55;
//amount wheels are offset by because of different size to keep tank horizontal
wheelOffset=(bigPulleyDiameter-littlePulleyDiameter)/2;
//center distance between pinion gear and little wheel gear
pinionOffset=pinionGearDiameter/2+wheelGearDiameter/2;

//Location of gears/pulleys/motor/shafts

//little wheel
topBackWheel=[vehicleLength/2,0,-vehicleHeight/2+littlePulleyDiameter/2-rideHeight];
//big wheel
topFrontWheel=[-vehicleLength/2,0,-vehicleHeight/2+littlePulleyDiameter/2-rideHeight+wheelOffset];
pinionGear=[topBackWheel[0]-sqrt(abs(pow(pinionOffset,2)-pow(topBackWheel[2],2))),0,0];


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
		{
			union()
			{

			rotate([90,0,0])
			translate([0,0,-wallThickness/2])
			linear_extrude(height=wallThickness)
			{


				polygon([[topFrontWheel[0],topFrontWheel[2]+strength],[pinionGear[0],pinionGear[2]+strength],
						[topBackWheel[0],topBackWheel[2]+strength],[topBackWheel[0],topBackWheel[2]-strength],
						[pinionGear[0],pinionGear[2]-strength],[topFrontWheel[0],topFrontWheel[2]-strength]]);

				translate([topFrontWheel[0],topFrontWheel[2]])
				circle(strength);

				translate([pinionGear[0],pinionGear[2]])
				circle(strength);
	
				translate([topBackWheel[0],topBackWheel[2]])
				circle(strength);
			}







				//support to keep axle square LHS
				translate([topBackWheel[0],topBackWheel[1]-width/2,topBackWheel[2]])
				rotate([-90,0,0])
				cylinder(width*3,strength,strength);

				//support to keep axle square RHS
				translate([topFrontWheel[0],topFrontWheel[1]-width/2,topFrontWheel[2]])
				rotate([-90,0,0])
				cylinder(width*3,strength,strength);
			}

			//cutout for motor holder
			translate([pinionGear[0],holeExtension/2,pinionGear[2]])
			rotate([-90,0,180])
			motorHolder(true);
			


			//cutout to save on plastic
			translate([topFrontWheel[0]/2,topFrontWheel[1],0])
			rotate([-90,0,0])
			cylinder(width,
			min(vehicleHeight/2-wallThickness,(
			topFrontWheel[0]-boltDiameter/2-motorDiameter/2-wallThickness*3)/2),
			min(vehicleHeight/2-wallThickness,
			(topFrontWheel[0]-boltDiameter/2-motorDiameter/2-wallThickness*3)/2),true);


			//cutout to save on plastic
			translate([topBackWheel[0]/2,topBackWheel[1],0])
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



	translate([pinionGear[0],(motorLength+holeExtension-width)/2+holeExtension/2,pinionGear[2]])
	rotate([-90,0,180])
	motorHolder();
}


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



module wheelGearAndPulley()
{
	//first make gear
	wheel(wheelGearDXF,wheelGearDiameter,wallThickness);
	//then put pulley on top of gear
	translate([0,0,wallThickness])
	{	
		difference()
		{
			//cut away bearing lip of pulley
			wheel(littlePulleyDXF,littlePulleyDiameter,15,false,true);
			cylinder(bearingLip,22.5/2,22.5/2);
		}
	}
}


//creates a wheel with bearing hub using DXF file and specifying diameter. 
//Diameter may or may not be used just to calculate position of cutouts
module wheel(DXF,diameter,width,grubScrewShaft,rim)
{
		//number of holes to cutout to save printing time
		cutOutHoleDiameter=diameter/5;
		numberOfHoles=6;
		offset=1;
	

	difference()
	{
		union()
		{
			if(rim==true)
			{
				//This is the DXF extruded to wallThickness
				translate([0,0,width/2+offset])
				linear_extrude(height=width,center=true,convexity=10)
				import (file = DXF);	
				
				//rim
				cylinder(offset,diameter/2+1,diameter/2+0);
				translate([0,0,width+offset])			
				cylinder(offset,diameter/2,diameter/2+1);	
			}
			else
			{
				//This is the DXF extruded to wallThickness
				translate([0,0,width/2])
				linear_extrude(height=width,center=true,convexity=10)
				import (file = DXF);
			}

			
			//fill shaft hole in dxf to allow custom shaft cutout
			cylinder(width+offset,diameter/4,diameter/4);
			
			//if grub screw shaft add grub screw support
			if(grubScrewShaft==true)
			{	
				intersection()
				{	
					union()
					{	
						cylinder(motorShaftLength-wallThickness,15/2,15/2);
	
						translate([0,8/2,(motorShaftLength-wallThickness)/2])
						cube([15,8,motorShaftLength-wallThickness],true);
					}	
					//this is to round the corners off the grub screw holder
					//so that I can get a bit closer with my gears
					cylinder(motorShaftLength-wallThickness,9,9);
				}
			}	





			//if its a bearing hub  add geometery for bearing cutout
			if(grubScrewShaft!=true&&width+2*offset<8)
			{
				//bearing holder (when shaft width is less than 8mm
				cylinder(8,14,14);
			}
		}//end Union

		//if we want grub screw to secure to shaft then add stuff here
		if(grubScrewShaft==true)
		{
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
		//if its a bearing hub  add geometery for bearing cutout
		if(grubScrewShaft!=true)
		{
			//bearing cutout
			translate([0,0,(width+2*offset)/2+bearingLip])
			bearingExternalGeom(22.5,width+2*offset);
	
			//axle cutout
			cylinder(width+2*offset,(22.5-2)/2,(22.5-2)/2);
		}



		/*holes to save on plastic.. too much trouble
		for ( i = [0 : numberOfHoles] )
		{
   		rotate( i * 360 / numberOfHoles,[0, 0, 1])
			translate([cutOutHoleDiameter*1.5,0,0])
			//holes to save on plastic
			cylinder(30,cutOutHoleDiameter/2,cutOutHoleDiameter/2,true);
		}
		*/
	}

}
module washer()
{
	//1.5mm washer for gear
	difference()
	{
		union()
		{
			//top bit
			cylinder(bearingLip+.5,(boltDiameter+3)/2,(boltDiameter+3)/2);
			//bottom bit
			cylinder(bearingLip,(22.5-3)/2,(22.5-3)/2);
		}
		cylinder(bearingLip+.5,boltDiameter/2,boltDiameter/2);
	}
}
//putItAllTogether();
//wheelGearAndPulley();
//color("red")
//washer();
module putItAllTogether()
{
//put it together for viewing
//back Right big pulley
translate([0,(-vehicleLength/2)-(wallThickness),0])
translate(topFrontWheel)
rotate([90,0,0])
wheel(bigPulleyDXF,bigPulleyDiameter,15,false,true);

//front right wheel gear
translate([0,(-vehicleLength/2),0])
translate(topBackWheel)
rotate([90,0,0])
wheelGearAndPulley();

/*
//back left wheel pulley
translate([0,(vehicleLength/2)+(wallThickness),0])
translate(topBackWheel)
rotate([-90,0,0])
wheel(littlePulleyDXF,littlePulleyDiameter,15,false,true);

//front Left big gear
translate([0,(vehicleLength/2)+(wallThickness),0])
translate(topFrontWheel)
rotate([-90,0,0])
wheel(bigPulleyDXF,bigPulleyDiameter,15,false,true);

//back left big gear
translate([0,(vehicleLength/2),0])
translate(topBackWheel)
rotate([-90,0,0])
wheel(wheelGearDXF,wheelGearDiameter,wallThickness);

//back left pinion gear
translate([0,(vehicleLength/2),0])
translate(pinionGear)
rotate([-90,0,0])
wheel(pinionGearDXF,pinionGearDiameter,wallThickness,true);
*/
//right pinion gear
translate([0,-(vehicleLength/2),0])
translate(pinionGear)
rotate([90,0,0])
wheel(pinionGearDXF,pinionGearDiameter,wallThickness,true);
/*
*/
//Right side 
translate([0,-(vehicleLength/2-width/2),0])
//rotate([0,0,180])
axles();
/*
//Left side
translate([0,(vehicleLength/2-width/2),0])
rotate([180,0,0])
axles();

//lid
translate([-vehicleLength/2,0,vehicleLength/2])
rotate([0,-90,0])
chassisLid();

//motor RHS
translate([0,-(vehicleLength/2-motorLength/2-width),0])
translate(pinionGear)
rotate([90,180,0])
motor();

//motor LHS
translate([0,(vehicleLength/2-motorLength/2-width),0])
translate(pinionGear)
rotate([-90,0,0])
motor();
//*/
}

//chassisBase();
//bigGear();
//rotate([90,0,0])
//axles();
//motor();
//motorHolder();

//axles();


