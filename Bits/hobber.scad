//Hobbed bolt hobber thingy.
//The plan is to hold the bolt and m4 tap securely in position.
//My openscad is pretty bad :(

use <Bolt.scad>;
use <Bearing.scad>;
use <Tap.scad>;

//Parameters ***********************************
//frame length
length=35;

//frame width
width=35;

//frame height
height=29.5;

//with of support structure for hinge overhang
supportWidth=0.7;

//Measurement from end of tap to thread center
tapThreadCenter=10;

//tap end bearing dimensions
tapBearingWidth=5;
tapBearingDiameter=13.5;

//bolt bearing dimension
boltBearingWidth=7;

//bolt dimensions
boltDiameter=8;

//hinge diameter
hingeDiameter=6;

//print wall thickness
wallThickness=1;
//**********************************************

//Things to do..........
//need to create module for bearing washers for bolt bearing outer race
//need to create module for washer for tap bearing outer race
//probably do in Bearing.scad


//main frame of tool
module bottomBit(length,width,height)
{
	difference()
	{
		//cube for frame centered
		cube([length,width,height],true);

		//lhs bolt bearing. Tap is placed off center to put bolt under thread of tap.
		translate([-width/2+boltBearingWidth/2,(width/2-tapThreadCenter-tapBearingWidth),0])rotate([0,90,0])boltBearing();
	
		//rhs bolt bearing...
		translate([width/2-boltBearingWidth/2,(width/2-tapThreadCenter-tapBearingWidth),0])rotate([0,90,0])boltBearing();
		
		//bolt shaft
		translate([-width/2,(width/2-tapThreadCenter-tapBearingWidth),0])rotate([0,90,0])cylinder(width,boltDiameter/2,boltDiameter/2);

		//remove space for top bit
		topBitExternal();
			

		//Hinge cutout
		//remove square at top.
		//translate([0,0,16])cube([21,length,3],true);
		translate([0,width/2-hingeDiameter/2,height/2-hingeDiameter/2])
		{
			rotate([180,0,0])
			{
		
				difference()
				//create semi circle (first bit of hinge cutout
				{
					rotate([0,90,0])cylinder(length-10,hingeDiameter/2,hingeDiameter/2,true);
					//semi circle required to allow for support material later
					translate([0,-hingeDiameter/4,0])cube([length-10,hingeDiameter/2,hingeDiameter],true);			
				}
			
			//vary hinge length here
			translate([0,-hingeDiameter/4+(supportWidth/2),0])cube([length-10,hingeDiameter/2-supportWidth,hingeDiameter],true);	
			}
		}
		//elongated sphere to cut from bottom frame to allow topbit to rotate
		//need to find out a more efficient way to do this as it is very slow to render if
		//i increase iterations.
		for ( i = [20 : 10 : 90] )
		{
			translate([0,width/2-(tapBearingWidth+4*wallThickness)/2,boltDiameter/2])rotate([i,0,0])cylinder(tapBearingWidth+4*wallThickness,tapBearingDiameter/2+3*wallThickness,tapBearingDiameter/2+3*wallThickness,true);
			echo("Whats taking so long");
			echo();
		}
	}
	
		
	}


module boltBearing()
	{
	intDiameter=8;
	extDiameter=22.5;
	width=7;
	bearingExternalGeom(extDiameter,width);
	}

module tapBearing()
	{
	intDiameter=4;
	extDiameter=13.5;
	width=5.5;
	bearingExternalGeom(extDiameter,width);
	}

module tapBearing2()
	{
	intDiameter=8;
	extDiameter=22.5;
	width=7;
	bearingExternalGeom(extDiameter,width);
	}

module M4Tap()
	{
	diameter=4;
	sqrSize=3.1;
	sqrLength=8;
	shankLength=23;
	threadLength=24;
	Tap(diameter,sqrSize,sqrLength,shankLength,threadLength);
	}

module M8Bolt()
	{
	diameter=8;
	length=50;
	head_size=13;
	head_depth=4.8;
	Bolt(diameter,length,head_size,head_depth);
	}

module 4Bolts()
	{
	cylinder(50,1.5,1.5);
	}


//topBit minus stuff
module topBit()
	{
	difference()
		{
		union() 
			{
			topBitExternal();

			//hinge
			//translate([0,length/2-3,11.75])rotate([0,90,0])cylinder(25,3,3,true);

			translate([0,width/2-hingeDiameter/2,height/2-hingeDiameter/2])
			rotate([0,90,0])cylinder(length-10,hingeDiameter/2,hingeDiameter/2,true);

			}
		//cutout for bolt
		translate([0,3,0])
			{
			rotate([0,90,0])
				{
				translate([2.5,0,0])cube([5,10,50],true);
				cylinder(50,5,5,true);
				}
			//tap viewing hole
			cylinder(30,4.5,4.5);	
			}
		//tap front bearing
		translate([0,-width/2+tapBearingWidth/2+1*wallThickness,boltDiameter/2])
		rotate([90,0,0])bearingExternalGeom(tapBearingDiameter,tapBearingWidth);

		translate([0,-width/2+tapBearingWidth/2+1*wallThickness,-(tapBearingDiameter+6*wallThickness)/2/2+boltDiameter/2])
		cube([tapBearingDiameter,tapBearingWidth,(tapBearingDiameter+6*wallThickness)/2],true);


		//tap back bearing
		translate([0,width/2-tapBearingWidth/2-1*wallThickness,boltDiameter/2])
		rotate([90,0,0])bearingExternalGeom(tapBearingDiameter,tapBearingWidth);

		translate([0,width/2-tapBearingWidth/2-1*wallThickness,-(tapBearingDiameter+6*wallThickness)/2/2+boltDiameter/2])
		cube([tapBearingDiameter,tapBearingWidth,(tapBearingDiameter+6*wallThickness)/2],true);


		//tap shaft
		translate([0,width/2+3,4])rotate([90,0,0])cylinder(width+6,2,2);

		}


	}
//topBitExternal used to subtract from bottomBit
module topBitExternal()
	{



//////////////////////////	
//	difference()
//		{
		//end cylinders. Need to change 7 to bolt bearing.width somehow.
		//long large cylinder
		//-7 to give room for bearings of 7 at each side
 
	//	translate([0,length/2+2,4])rotate([90,0,0])
	//		{
	//		cylinder(length+4,width/2-7,width/2-7);
	//		}
		//minus center to leave two ends
		//2*5 for bearing, -2 for 1mm bearing backing
	//	translate([0,length/2-tapBearingWidth-wallThickness,4])rotate([90,0,0])cylinder(length-(2*tapBearingWidth)-(2*wallThickness),12,12);
	//	}
/////////////

	translate([0,width/2-(tapBearingWidth+4*wallThickness)/2,boltDiameter/2])
	rotate([90,0,0])
	cylinder(tapBearingWidth+4*wallThickness,tapBearingDiameter/2+3*wallThickness,tapBearingDiameter/2+3*wallThickness,true);

	translate([0,-(width/2-(tapBearingWidth+4*wallThickness)/2),boltDiameter/2])
	rotate([90,0,0])
	cylinder(tapBearingWidth+4*wallThickness,tapBearingDiameter/2+3*wallThickness,tapBearingDiameter/2+3*wallThickness,true);

	//shaft
	translate([0,length/2-6,4])rotate([90,0,0])cylinder(length-13,6.5,6.5);	

	//top square bit
	//keeping things parametric is tricky
	translate([0,0,boltDiameter/2+(height/2-boltDiameter/2)/2])

	
		//cube([tapBearingDiameter+6*wallThickness,width,(tapBearingDiameter+6*wallThickness)/2],true);
		cube([tapBearingDiameter+6*wallThickness,width,height/2-boltDiameter/2],true);
		
	}


//Render this
//translate([0,0,height/2+1.5]){
//bottomBit(length,width,height);
//}
//translate([0,-length/2-20,4])rotate([270,0,0]) M4Tap();
//translate([-length/2-7,0,0])rotate([0,90,0])M8Bolt();
//translate([0,0,height/2])rotate([0,180,0]){
topBit();
//}
//translate([0,length/2-3.5,4])



	
//topBitExternal();


