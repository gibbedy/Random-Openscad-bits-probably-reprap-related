
$fn=50;

//layer height used when printing
layerHeight=.3;
extrusionWidth=.7;
	//I have added 2mm to camera dimensions to allow for padding
	//to be inserted
	cameraLength=61;
	cameraWidth=23;
	cameraHeight=43;

	cameraLenseHeight=8;
	cameraLenseDiameter=24;

	baseSupportDiameter=10;
	baseSupportHeight=10;
	baseSupportScrewDiameter=4.5;
	
	//located 27.5mm from the bottom and 44.5mm from the left edge	 on my gopro3
	lenseXOffset=-(44.5-cameraLength/2);
	lenseZOffset=27.5-cameraHeight/2;


	//Thickness of walls. Increase to make stronger
	wallThickness=4*extrusionWidth;
		hingeDiameter=15;
	hingeThickness=3;
	hingeGap=3.4;
	hingeBoltDiameter=5.5;
	hingeYOffset=(cameraWidth+2*wallThickness-hingeDiameter)/2;
	
	//securing tab dimensions
	tabX=10;
	tabY=10;
	tabZ=1.5;

	bracketLength=25;
	bracketHoleSpacing=8.5;
	bracketScrewDiameter=4.5;

//model of camera
module hero3()
{


	//body of camera
	cube([cameraLength,cameraWidth,cameraHeight],true);

	//lense of camera
	//*temp*located 27.5mm from the bottom and 44.5mm from the left edge	
	translate([lenseXOffset,cameraWidth/2,lenseZOffset])
	rotate([-90,0,0])
	cylinder(cameraLenseHeight,cameraLenseDiameter/2,cameraLenseDiameter/2);
}

//space needed for usb plug
module usbPlugCutout()
{
	usbPlugLength=10;
	usbPlugWidth=20;
	usbPlugHeight=10;

//	rotate([180,0,0])s
	//usb plug locate 5mm from front and 10mm from bottom
	translate([-cameraLength/2-usbPlugLength/2,-(usbPlugWidth/2-cameraWidth/2+3),10-cameraHeight/2])
	cube([usbPlugLength,usbPlugWidth,usbPlugHeight],true);
}

module mountingBracket()
{

	difference()
	{
	//main shaft	
	translate([0,0,-(bracketLength-hingeDiameter/2+bracketHoleSpacing/2+5)/2])
	cube([hingeThickness*4+hingeGap,hingeDiameter,bracketLength-hingeDiameter/2+bracketHoleSpacing/2+5],true);
	
	//minus mounting screws
	translate([0,0,-(bracketLength-hingeDiameter/2+bracketHoleSpacing/2)])
rotate([90,0,0])
cylinder(hingeDiameter,bracketScrewDiameter/2,bracketScrewDiameter/2,true);

	translate([0,0,-(bracketLength-hingeDiameter/2-bracketHoleSpacing/2)])
rotate([90,0,0])
cylinder(hingeDiameter,bracketScrewDiameter/2,bracketScrewDiameter/2,true);

/*
	//Although pretty I have taken away to get maximum strength.

	//minus a bit to flatten end
	translate([0,-hingeDiameter/4,(bracketHoleSpacing+2*5)/2-(bracketLength+bracketHoleSpacing/2+5-hingeDiameter/2)])
	cube([hingeThickness*5,hingeDiameter/2,bracketHoleSpacing+2*5],true);

	//minus cylinder to round off corner
	translate([0,-hingeDiameter/2,-(bracketLength-bracketHoleSpacing/2-5-hingeDiameter/2)])
	rotate([0,90,0])
	#cylinder(5*hingeThickness+.001,hingeDiameter/2,hingeDiameter/2,true);
*/
	}	
	difference()
	{
		union()
		{
				//hinge cylinder middle
				translate([0,0,hingeDiameter/2])	
				rotate([0,90,0])
				cylinder(hingeGap,hingeDiameter/2,hingeDiameter/2,true);

				//hinge cylinder bottombit middle
				translate([0,0,hingeDiameter/4])
				cube([hingeGap,hingeDiameter,hingeDiameter/2],true);

				//hinge cylinder RHS
				translate([-(hingeThickness*2+(hingeGap-hingeThickness)/2),0,hingeDiameter/2])	
				rotate([0,90,0])
				cylinder(hingeThickness,hingeDiameter/2,hingeDiameter/2,true);

				//hinge cylinder bottombit RHS
				translate([-(hingeThickness*2+(hingeGap-hingeThickness)/2),0,hingeDiameter/4])
				cube([hingeThickness,hingeDiameter,hingeDiameter/2],true);

				//hinge cylinder LHS
				translate([(hingeThickness*2+(hingeGap-hingeThickness)/2),0,hingeDiameter/2])	
				rotate([0,90,0])
				cylinder(hingeThickness,hingeDiameter/2,hingeDiameter/2,true);

				//hinge cylinder bottombit LHS
				translate([(hingeThickness*2+(hingeGap-hingeThickness)/2),0,hingeDiameter/4])
				cube([hingeThickness,hingeDiameter,hingeDiameter/2],true);
		}
		//minus screw hole
		translate([0,0,hingeDiameter/2])
		rotate([0,90,0])
		cylinder(hingeThickness*4+hingeGap,hingeBoltDiameter/2,hingeBoltDiameter/2,true);

	}//difference
}
module hinge()
{
	translate([(lenseXOffset),0,cameraHeight/2+wallThickness])
	{
	
		difference()
		{
			union()
			{
				//hinge cylinder LHS
				translate([hingeThickness/2+hingeGap/2,-hingeYOffset,hingeDiameter/2])	
				rotate([0,90,0])
				cylinder(hingeThickness,hingeDiameter/2,hingeDiameter/2,true);

				//hinge cylinder bottombit LHS
				translate([hingeThickness/2+hingeGap/2,-hingeYOffset,hingeDiameter/4])
				cube([hingeThickness,hingeDiameter,hingeDiameter/2],true);

				//hinge cylinder RHS
				translate([-(hingeThickness/2+hingeGap/2),-hingeYOffset,hingeDiameter/2])	
				rotate([0,90,0])
				cylinder(hingeThickness,hingeDiameter/2,hingeDiameter/2,true);

				//hinge cylinder bottombit RHS
				translate([-(hingeThickness/2+hingeGap/2),-hingeYOffset,hingeDiameter/4])
				cube([hingeThickness,hingeDiameter,hingeDiameter/2],true);

	
			}
		translate([0,-hingeYOffset,hingeDiameter/2])
		rotate([0,90,0])
		cylinder(hingeThickness*2+hingeGap,hingeBoltDiameter/2,hingeBoltDiameter/2,true);
		}
	}
	
}
module case()
{
	difference()
	{
		cube([cameraLength+wallThickness*2,cameraWidth+wallThickness*2,cameraHeight+wallThickness*2],true);
		translate([0,-wallThickness,0])
		//cutout to allow install of gopro3
		cube([cameraLength,cameraWidth,cameraHeight],true);

		//slots for top tab
		translate([tabX/2+1/2,-(cameraWidth+2*wallThickness-tabY)/2,(cameraHeight+wallThickness)/2])
		cube([1,tabY,wallThickness],true);

		translate([-(tabX/2+1/2),-(cameraWidth+2*wallThickness-tabY)/2,(cameraHeight+wallThickness)/2])
		cube([1,tabY,wallThickness],true);

		//slots for bottom tab
		translate([tabX/2+1/2,-(cameraWidth+2*wallThickness-tabY)/2,-(cameraHeight+wallThickness)/2])
		cube([1,tabY,wallThickness],true);

		translate([-(tabX/2+1/2),-(cameraWidth+2*wallThickness-tabY)/2,-(cameraHeight+wallThickness)/2])
		cube([1,tabY,wallThickness],true);

		//slots for rhs tab
		translate([(cameraLength+wallThickness)/2,-(cameraWidth+2*wallThickness-tabY)/2,tabX/2+1/2])
		rotate([0,90,0])
		cube([1,tabY,wallThickness],true);

		translate([(cameraLength+wallThickness)/2,-(cameraWidth+2*wallThickness-tabY)/2,-(tabX/2+1/2)])
		rotate([0,90,0])
		cube([1,tabY,wallThickness],true);

		//slots for lhs tab
		translate([-(cameraLength+wallThickness)/2,-(cameraWidth+2*wallThickness-tabY)/2,tabX/2+1/2+5])
		rotate([0,-90,0])
		cube([1,tabY,wallThickness],true);

		translate([-(cameraLength+wallThickness)/2,-(cameraWidth+2*wallThickness-tabY)/2,-(tabX/2+1/2)+5])
		rotate([0,-90,0])
		cube([1,tabY,wallThickness],true);

		usbPlugCutout();
		hero3();

	}
		//tab to secure gopro in
		//top tab
		translate([0,-(cameraWidth/2+wallThickness/2),cameraHeight/2-tabZ/2])
		tab();

		//bottom tab
		translate([0,-(cameraWidth/2+wallThickness/2),-(cameraHeight/2-tabZ/2)])
		rotate([0,180,0])
		tab();

		//rhs tab
		translate([(cameraLength/2-tabZ/2),-(cameraWidth/2+wallThickness/2),0])
		rotate([0,90,0])
		tab();

		//lhs tab
		translate([-(cameraLength/2-tabZ/2),-(cameraWidth/2+wallThickness/2),5])
		rotate([0,-90,0])
		tab();




		//added geom for lense hole to avoid support material
	translate([lenseXOffset,cameraWidth/2,lenseZOffset])
	rotate([-90,0,0])
	#cylinder(layerHeight,cameraLenseDiameter/2,cameraLenseDiameter/2);
}

module tab()
{
		//triangle
		difference()
		{
			
			#cube([tabX,wallThickness,tabZ],true);
			translate([0,-wallThickness/2,-tabZ/2])
			rotate([-45,0,0])
			#cube([tabX,wallThickness,tabZ],true);
			
		}


}
//base to mount to top plate of hornet 460
module bracketBase()
{


	//standoffs to allow flight controller to fit underneath
	rotate([0,0,0])
	translate([90/2,0,0])
	mountingHolePairs();
	
	rotate([0,0,90])
	translate([90/2,0,0])
	mountingHolePairs();

	rotate([0,0,180])
	translate([90/2,0,0])
	mountingHolePairs();

	rotate([0,0,270])
	translate([90/2,0,0])
	mountingHolePairs();
	
	//base of camera mounting plate
	translate([0,0,baseSupportHeight])
	cylinder(wallThickness,90/2+baseSupportDiameter,90/2+baseSupportDiameter);


}
//used in bracketBase()
module mountingHolePairs()
{
	//holes in top plate for screwing this contraption to are located
	//in pairs at 36mm hole centers.
	//these pairs are located 90mm apart	
	//need to look at top support with a ruler for this to make sense
	translate([0,36/2,0])
	difference()
	{
	cylinder(baseSupportHeight,baseSupportDiameter/2,baseSupportDiameter/2);
	//hole for screw thread to be tapped into
	cylinder(baseSupportHeight,baseSupportScrewDiameter/2,baseSupportScrewDiameter/2);
	}
	translate([0,-36/2,0])
	difference()
	{
	cylinder(baseSupportHeight,baseSupportDiameter/2,baseSupportDiameter/2);
	//hole for screw thread to be tapped into
	cylinder(baseSupportHeight,baseSupportScrewDiameter/2,baseSupportScrewDiameter/2);
	}
}

//translate([(44.5-cameraLength/2),0,cameraHeight/2+wallThickness+baseSupportHeight])
//rotate([90,0,0])
{
//case();
//hinge();
}
//bracketBase();

//rotate([-90,0,0])
mountingBracket();
