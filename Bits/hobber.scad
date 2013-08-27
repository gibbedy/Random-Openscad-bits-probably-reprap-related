//Hobbed bolt hobber thingy.
//The plan is to hold the bolt and m4 tap securely in position.
//My openscad is pretty bad :(

use <Bolt.scad>;
use <Bearing.scad>;
use <Tap.scad>;


//Parameters ***********************************

//uncomment to increase resolution of cylinders
$fn=50;
//frame length
lengthDesired=35;

//frame width
widthDesired=35;

//frame height
heightDesired=10;


//with of support structure for hinge overhang
//supportWidth=0.7;

//Measurement from end of tap to thread center
tapThreadCenter=10;

//tap end bearing dimensions
tapBearingWidth=7.5;
tapBearingDiameter=22.5;
tapBearingIntDiameter=8;

//tap end bearing 2 dimensions
tapBearing2Width=7.5;
tapBearing2Diameter=22.5;
tapBearing2IntDiameter=8;


//bolt bearing dimension
boltBearingWidth=7.5;
boltBearingIntDiameter=8;
boltBearingExtDiameter=22.5;
boltBearingRaceWidth=2;

//bolt dimensions
boltDiameter=8;

//hinge diameter
hingeDiameter=6;

//tap diameter being used for hobbing
tapDiameter=4;

//print wall thickness
wallThickness=.83;

//bearing strength factor
//number of extra material required to hold bearing
//need to experiment with material
bearingStrength=2;
//wall strength factor
//with of walls for bearings
//need to experiment with material
wallStrength=2;

//width of ring to hold tap bearings in place
bearingLocatorWidth=.125;

//increase Hobber width as required for bearings used
width=max(widthDesired,tapBearingWidth+tapBearing2Width+boltBearingExtDiameter);

//increase Hobber length as required for bearings used
length=max(lengthDesired,max(tapBearingDiameter,tapBearing2Diameter)+bearingStrength*2*wallThickness+2*(boltBearingWidth+wallThickness));
echo("length=",width);

//increase Hobber height as required for bearings used
height=maxOf3(heightDesired,(tapBearing2Diameter+bearingStrength*2*wallThickness+boltDiameter),(tapBearingDiameter+bearingStrength*2*wallThickness+boltDiameter));
//**********************************************

//Things to do..........
//**********************************************

//main frame of tool
module bottomBit(length,width,height)
{
	
	//lhs bolt washer for bearing outer race
	translate([-length/2+boltBearingWidth-.5/2,(width/2-tapThreadCenter-tapBearingWidth),0])
	rotate([0,90,0])
	bearing(boltBearingExtDiameter,boltBearingExtDiameter-boltBearingRaceWidth,.5);

	//rhs bolt washer for bearing outer race
	translate([length/2-boltBearingWidth+.5/2,(width/2-tapThreadCenter-tapBearingWidth),0])
	rotate([0,90,0])
	bearing(boltBearingExtDiameter,boltBearingExtDiameter-boltBearingRaceWidth,.5);

	difference()
	{
		//cube for frame centered
		cube([length,width,height],true);

		//lhs bolt bearing. Tap is placed off center to put bolt under thread of tap.
		translate([-length/2+boltBearingWidth/2,(width/2-tapThreadCenter-tapBearingWidth),0])
		rotate([0,90,0])
		bearingExternalGeom(boltBearingExtDiameter,boltBearingWidth);
	
		//rhs bolt bearing...
		translate([length/2-boltBearingWidth/2,(width/2-tapThreadCenter-tapBearingWidth),0])
		rotate([0,90,0])
		bearingExternalGeom(boltBearingExtDiameter,boltBearingWidth);
		
		//bolt shaft
		translate([-length/2,(width/2-tapThreadCenter-tapBearingWidth),0])
		rotate([0,90,0])
		cylinder(length,boltDiameter/2,boltDiameter/2);

		//remove space for top bit
		topBitExternal();
			

		//Hinge cutout
		translate([0,width/2-hingeDiameter/2,height/2-hingeDiameter/2])
		{
			rotate([180,0,0])
			{
		
				difference()
				//create semi circle (first bit of hinge cutout
				{
					rotate([0,90,0])cylinder(max(tapBearingDiameter,tapBearing2Diameter)+bearingStrength*2*wallThickness+5,hingeDiameter/2,hingeDiameter/2,true);
					//semi circle required to allow for support material later
					translate([0,-hingeDiameter/4,0])
					cube([max(tapBearingDiameter,tapBearing2Diameter)+bearingStrength*2*wallThickness+5,hingeDiameter/2,hingeDiameter],true);			
				}
			
			//vary hinge length here
			translate([0,-hingeDiameter/4+(wallThickness/2),0])
			cube([max(tapBearingDiameter,tapBearing2Diameter)+bearingStrength*2*wallThickness+5,hingeDiameter/2-wallThickness,hingeDiameter],true);	
			}
		}
		//elongated sphere to cut from bottom frame to allow topbit to rotate
		//need to find out a more efficient way to do this as it is very slow to render if
		//increase number of loops to increase resolution
		for ( i = [20 : 10 : 90] )
		{
			translate([0,width/2-(tapBearingWidth+wallStrength*wallThickness)/2,boltDiameter/2])
			rotate([i,0,0])
			cylinder(tapBearingWidth+wallStrength*wallThickness,tapBearingDiameter/2+bearingStrength/2*wallThickness,tapBearingDiameter/2+bearingStrength/2*wallThickness,true);
		}
	}
	//hinge top strength
	//Top bit to add strength to hinge**************************************************
	//Need to look at as is overly complicated
	translate([0,width/2-(hingeDiameter+hingeDiameter/2*wallThickness)/2,height/2+(hingeDiameter/2*wallThickness)/2])
	{		
		difference()
		{
			intersection()
			{
				translate([0,(hingeDiameter/2*wallThickness)/2,-hingeDiameter/2-(hingeDiameter/2*wallThickness)/2])
				{
					rotate([0,90,0])
					cylinder(length,(hingeDiameter+hingeDiameter*wallThickness)/2,(hingeDiameter+hingeDiameter*wallThickness)/2,true);
				}
				
				cube([length,hingeDiameter+hingeDiameter/2*wallThickness,hingeDiameter/2*wallThickness],true);
			}

			//cut out center bit where topbit goes
			cube([(max(tapBearingDiameter,tapBearing2Diameter)+bearingStrength*2*wallThickness),hingeDiameter+hingeDiameter/2*wallThickness,hingeDiameter/2*wallThickness],true);	
			}
	}

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

//topBit minus stuff
module topBit()
{
	difference()
	{
		union() 
		{
			topBitExternal();

			//hinge
			translate([0,width/2-hingeDiameter/2,height/2-hingeDiameter/2])
			rotate([0,90,0])
			cylinder(max(tapBearingDiameter,tapBearing2Diameter)+bearingStrength*2*wallThickness+5,hingeDiameter/2,hingeDiameter/2,true);
		}
		//cutout for bolt
		///////////////////////////////////////////////////////////////fix
		translate([0,width/2-tapThreadCenter-tapBearingWidth,0])
		{
			rotate([0,90,0])
			{
				translate([(boltDiameter+wallThickness)/2,0,0])cube([(boltDiameter+wallThickness),(boltDiameter+wallThickness),length],true);
				cylinder(length,(boltDiameter+wallThickness)/2,(boltDiameter+wallThickness)/2,true);
			}
			//tap viewing hole
			cylinder(30,4.5,4.5);	
		}

		//tap front bearing
		//translate([0,-(width/2-(tapBearing2Width+wallStrength*wallThickness)/2),boltDiameter/2])
		translate([0,-(width/2-(tapBearing2Width)/2+.01),boltDiameter/2])
		rotate([90,0,0])bearingExternalGeom(tapBearing2Diameter,tapBearing2Width);
		
		//slot to insert bearing
		//translate([0,-(width/2-(tapBearing2Width+wallStrength*wallThickness)/2),-(tapBearing2Diameter+bearingStrength*2*wallThickness)/2/2+boltDiameter/2])
		//cube([tapBearing2Diameter,tapBearing2Width,(tapBearing2Diameter+bearingStrength*2*wallThickness)/2],true);

		//cutout to free bearing inner race and allow for bush to adjust internal hole size
		translate([0,-(width/2-(tapBearing2Width)/2+.01),boltDiameter/2])
		rotate([90,0,0])
		cylinder(tapBearing2Width+1,tapBearing2IntDiameter/2+2,tapBearing2IntDiameter/2+2,true);


		//tap back bearing
		//translate([0,width/2-(tapBearingWidth+wallStrength*wallThickness)/2,boltDiameter/2])
		translate([0,width/2-(tapBearingWidth)/2+.01,boltDiameter/2])
		rotate([90,0,0])bearingExternalGeom(tapBearingDiameter,tapBearingWidth);

		//slot to insert bearing
		//translate([0,width/2-(tapBearingWidth+wallStrength*wallThickness)/2,-(tapBearingDiameter+bearingStrength*2*wallThickness)/2/2+boltDiameter/2])
		//cube([tapBearingDiameter,tapBearingWidth,(tapBearingDiameter+bearingStrength*2*wallThickness)/2],true);

		//cutout to free bearing inner race and allow for bush to adjust internal hole size
		translate([0,(width/2-(tapBearing2Width)/2+.01),boltDiameter/2])
		rotate([90,0,0])
		cylinder(tapBearingWidth+1,tapBearingIntDiameter/2+2,tapBearingIntDiameter/2+2,true);

		//tap shaft
		translate([0,width/2+3,4])rotate([90,0,0])cylinder(width+6,2,2);
	}

module notUsedanyMore()
{
	//bit for securing back bearing in 
	translate([0,width/2-(tapBearingWidth+wallStrength*wallThickness)/2,boltDiameter/2])
	rotate([90,0,0])
	{
		//side 1
		translate([0,0,(tapBearingWidth/2-bearingLocatorWidth/2)])
		bearing(tapBearingDiameter+bearingStrength*2*wallThickness,tapBearingDiameter,bearingLocatorWidth);

		//side 2
		translate([0,0,-(tapBearingWidth/2-bearingLocatorWidth/2)])
		bearing(tapBearingDiameter+bearingStrength*2*wallThickness,tapBearingDiameter,bearingLocatorWidth);
	}

	//bit for securing front bearing in 
	translate([0,-(width/2-(tapBearing2Width+wallStrength*wallThickness)/2),boltDiameter/2])
	rotate([90,0,0])
	{
		//side 1
		translate([0,0,(tapBearing2Width/2-bearingLocatorWidth/2)])
		bearing(tapBearingDiameter+bearingStrength*2*wallThickness,tapBearingDiameter,bearingLocatorWidth);

		//side 2
		translate([0,0,-(tapBearing2Width/2-bearingLocatorWidth/2)])
		bearing(tapBearingDiameter+bearingStrength*2*wallThickness,tapBearingDiameter,bearingLocatorWidth);
	}
}

}

//topBitExternal used to subtract from bottomBit
module topBitExternal()
{

	//tap bearing
	translate([0,width/2-(tapBearingWidth+wallStrength*wallThickness)/2,boltDiameter/2])
	rotate([90,0,0])
	cylinder(tapBearingWidth+wallStrength*wallThickness,tapBearingDiameter/2+bearingStrength*wallThickness,tapBearingDiameter/2+bearingStrength*wallThickness,true);

	//tapbearing2
	translate([0,-(width/2-(tapBearing2Width+wallStrength*wallThickness)/2),boltDiameter/2])
	rotate([90,0,0])
	cylinder(tapBearing2Width+wallStrength*wallThickness,tapBearing2Diameter/2+bearingStrength*wallThickness,tapBearing2Diameter/2+bearingStrength*wallThickness,true);

	//shaft
	translate([0,length/2-6,4])rotate([90,0,0])cylinder(length-tapBearingWidth-tapBearing2Width,max(tapBearingIntDiameter,tapBearing2IntDiameter)/2+1,max(tapBearingIntDiameter,tapBearing2IntDiameter)/2+1);	

	//top square bit
	//keeping things parametric is tricky
	translate([0,0,boltDiameter/2+ 
	maxOf3(height/2-boltDiameter/2,(tapBearing2Diameter+bearingStrength*2*wallThickness)/2,(tapBearingDiameter+bearingStrength*2*wallThickness)/2)/2])

	
	//needs to be the bigger of height or tapbearing2
	cube([max(tapBearingDiameter,tapBearing2Diameter)+bearingStrength*2*wallThickness,width,
	maxOf3(height/2-boltDiameter/2,(tapBearing2Diameter+bearingStrength*2*wallThickness)/2,(tapBearingDiameter+bearingStrength*2*wallThickness)/2)],true);
}

module tapBearingBush1()
{

//bush with tap clearance hole
	difference()
	{
		cylinder(tapBearingWidth,tapBearingIntDiameter/2,tapBearingIntDiameter/2);
		cylinder(tapBearingWidth,tapDiameter/2,tapDiameter/2);
	}
	//use layer width so no infil and just perimeters.
	//Slic3r gives me some funny stuff sometimes
	echo("Print at: ",(tapBearingIntDiameter/2-tapDiameter/2)/3,"mm Layer width");
}

module tapBearingBush2()
{

//bush for tap end
	translate([0,tapBearing2IntDiameter+1,0])
	difference()
	{
		cylinder(tapBearing2Width,tapBearing2IntDiameter/2,tapBearing2IntDiameter/2);
		cylinder(tapBearing2Width,tapDiameter*.84/2,tapDiameter*.84/2);
	}
	//use layer width so no infil and just perimeters.
	//Slic3r gives me some funny stuff sometimes
	echo("Print at: ",(tapBearing2IntDiameter/2-tapDiameter*.84/2)/3,"mm Layer width");
}


function maxOf3(val1,val2,val3)=max(val1,max(val2,val3));

//Render this
//translate([0,0,height/2+1.5]){

//}
//translate([0,-length/2-20,4])rotate([270,0,0]) M4Tap();
//translate([-length/2-7,0,0])rotate([0,90,0])M8Bolt();
//translate([0,0,0])rotate([0,180,0])
//topBit();
//}
//translate([37,0,0])
//bottomBit(length,width,height);

//translate([-20,0,-height/2])
tapBearingBush2();





	
//topBitExternal();



