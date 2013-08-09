//Hobbed bolt hobber thingy.
//Needs to hold the bolt and m4 tap securely in position.
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
//**********************************************


//main frame of tool
module bottomBit(length,width,height)
	{
	difference()
		{
		//cube for frame centered
		cube([length,width,height+3],true);

		//lhs bolt bearing
		translate([-width/2,0,0])rotate([0,90,0])boltBearing();
	
		//rhs bolt bearing.. need to parameterize the 7 here
		translate([width/2-7,0,0])rotate([0,90,0])boltBearing();
		
		//bolt shaft
		translate([-width/2,0,0])rotate([0,90,0])cylinder(width,4,4);

		//remove space for top bit
		topBitExternal();
			

	
		//remove square at top.
		translate([0,0,16])cube([21,length,3],true);
		translate([0,length/2-3,11.75])
			{
			rotate([180,0,0])
				{
		
				//create semi circle (first bit of hinge cutout
				difference()
					{
					translate([0,0,0])rotate([0,90,0])cylinder(25,3,3,true);
					translate([0,-1.5,0])cube([25,3,6],true);			
					}
				//vary hinge length here

				translate([0,-1.5+(supportWidth/2),0])cube([25,3-supportWidth,6],true);	
				}
			}
		//elongated sphere to cut from bottom frame to allow topbit to rotate
		for ( i = [20 : 10 : 90] )
			{
			translate([0,length/2-3.5,4])rotate([i,0,0])cylinder(7,width/2-7,width/2-7,true);
			}
		}
	hookForBand();
		
	}

module hookForBand()
	{
	translate([0,-length/2-2.5,-height/2])cube([2.5,5,3],true);	
	translate([0,-length/2-5,-height/2])cube([5,2.5,3],true);
	}

module tapBearing()
	{
	Bearing(4,13,5);
	}

module boltBearing()
	{
	intDiameter=8;
	extDiameter=22;
	width=7;
	bearingExternalGeom(extDiameter,width);
	}

module tapBearing()
	{
	intDiameter=4;
	extDiameter=13;
	width=5;
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
			//cutout for bolt
			//hinge
			translate([0,length/2-3,11.75])rotate([0,90,0])cylinder(25,3,3,true);
		}

		rotate([0,90,0])
			{
			translate([2.5,0,0])cube([5,10,50],true);
			cylinder(50,5,5,true);
			}
			//tap front bearing
			translate([0,-width/2+5,4])rotate([90,0,0])tapBearing();

			//tap back bearing
			translate([0,width/2-5,4])rotate([270,0,0])tapBearing();

			//tap shaft
			translate([0,width/2,4])rotate([90,0,0])cylinder(width,2,2);
				//tap viewing hole
			cylinder(30,4.5,4.5);	
		}
	
		translate([0,0,height-1.5])hookForBand();

	}
//topBitExternal used to subtract from bottomBit
module topBitExternal()
	{



	
	difference()
		{
		//end cylinders. Need to change 7 to bolt bearing.width somehow.
		//long large cylinder
		//-7 to give room for bearings of 7 at each side
		translate([0,length/2,4])rotate([90,0,0])cylinder(length,width/2-7,width/2-7);
		//minus center to leave two ends
		//2*5 for bearing, -2 for 1mm bearing backing
		translate([0,length/2-6,4])rotate([90,0,0])cylinder(length-(2*5)-(2),12,12);
		}

	//taper
	translate([0,length/2-6,4])rotate([90,0,0])cylinder(1.5,10.5,6.5);
	translate([0,-length/2+6,4])rotate([-90,0,0])cylinder(1.5,10.5,6.5);

	//shaft
	translate([0,length/2-6,4])rotate([90,0,0])cylinder(length-13,6.5,6.5);	

	//top square bit
	translate([0,0,9.5])
	
		cube([21,length,10.5],true);

	//hinge
	//translate([0,length/2-3,11.75])rotate([0,90,0])cylinder(25,3,3,true);


	

	
		
	}


//Render this
bottomBit(length,width,height);
translate([0,-length/2-20,4])rotate([270,0,0]) M4Tap();
translate([-length/2-7,0,0])rotate([0,90,0])M8Bolt();
topBit();

//topBitExternal();


