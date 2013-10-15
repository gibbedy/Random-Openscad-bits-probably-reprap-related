	
	//I have added 2mm to camera dimensions to allow for padding
	//to be inserted
	cameraLength=61;
	cameraWidth=23;
	cameraHeight=43;

	cameraLenseHeight=8;
	cameraLenseDiameter=23;

	baseSupportDiameter=10;
	baseSupportHeight=10;
	baseSupportScrewDiameter=4.5;
	
	//Thickness of walls. Increase to make stronger
	wallThickness=3;

//model of camera
module hero3()
{


	//body of camera
	cube([cameraLength,cameraWidth,cameraHeight],true);

	//lense of camera
	//*temp*located 27.5mm from the bottom and 44.5mm from the left edge	
	translate([-(44.5-cameraLength/2),cameraWidth/2,27.5-cameraHeight/2])
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

module case()
{
	cube([cameraLength+wallThickness*2,cameraWidth+wallThickness*2,cameraHeight+wallThickness*2],true);

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

translate([(44.5-cameraLength/2),0,cameraHeight/2+wallThickness+baseSupportHeight])
difference()
{
case();
usbPlugCutout();
hero3();
}

bracketBase();
