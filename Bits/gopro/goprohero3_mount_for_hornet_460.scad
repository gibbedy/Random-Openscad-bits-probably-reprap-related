//**********************************************************************************************
//This is my attempt at a GoPro3 mount for my Quadcopter (Dualsky Hornet 460)
//It has been designed to be printable without support and strong
//By specifying the extrusion width you will be printing and setting perimeters to 3 (in slic3r)
//printing will be pretty quick.
//**********************************************************************************************

//mm


$fn=50;


//layer height used when printing
layerHeight=.3;

//extrusionwidth to use when printing
extrusionWidth=.7;


//Camera Dimensions
//I have added 2mm to camera dimensions to allow for padding
//to be inserted
cameraLength=61;
cameraWidth=23;
cameraHeight=43;
cameraLenseHeight=8;
cameraLenseDiameter=25;


//located 27.5mm from the bottom and 44.5mm from the left edge	 on my gopro3
lenseXOffset=-(44.5-cameraLength/2);
lenseZOffset=28-cameraHeight/2;


//Base to be mounted on top plate of hornet 469. Not used but may need it in future on
baseSupportDiameter=10;
baseSupportHeight=10;
baseSupportScrewDiameter=4.5;

	
//Thickness of walls. Increase to make stronger
wallThickness=4*extrusionWidth;

//Dimensions for GoPro hinge
hingeDiameter=15;
hingeThickness=3;
hingeGap=3.4;
hingeBoltDiameter=5.5;
hingeYOffset=(cameraWidth+2*wallThickness-hingeDiameter)/2;
        
//Back door securing tab dimensions
tabDiameter=10;
tabScrewDiameter=3.5;        
RHStabOffset=10;


//Arm to attach gopro mount to hornet 460
bracketLength=25+7.5+3;
bracketHoleSpacing=8.5;
bracketScrewDiameter=3.5;

//Opening for USB plug (for FPV)
usbPlugLength=wallThickness+.1;
usbPlugWidth=15;
usbPlugHeight=13;

//wifi button
//10mm from back and 9.5mm from bottom left
wifiButtonDiameter=5.5;
wifiButtonYOffset=10;
wifiButtonZOffset=9.5;

tolerance=.0001;

//model of camera
module hero3()
{

	//body of camera
	cube([cameraLength,cameraWidth,cameraHeight],true);

	//lense of camera
	translate([lenseXOffset,cameraWidth/2,lenseZOffset])
	rotate([-90,0,0])
	cylinder(cameraLenseHeight,cameraLenseDiameter/2,cameraLenseDiameter/2);

   //body of camera
   cube([cameraLength,cameraWidth,cameraHeight],true);


   //lense of camera
   translate([lenseXOffset,cameraWidth/2,lenseZOffset])
   rotate([-90,0,0])
   cylinder(cameraLenseHeight,cameraLenseDiameter/2,cameraLenseDiameter/2);

}


//space needed for usb plug
module usbPlugCutout()
{

	//	rotate([180,0,0])s
	//usb plug locate 5mm from front and 10mm from bottom
	translate([-cameraLength/2-usbPlugLength/2,-(usbPlugWidth/2-cameraWidth/2),12-cameraHeight/2])
	cube([usbPlugLength,usbPlugWidth,usbPlugHeight],true);

}

module wifiButtonCutout()
{


	translate([(cameraLength+wallThickness+tolerance)/2,-cameraWidth/2+wifiButtonYOffset,-cameraHeight/2+wifiButtonZOffset])
	rotate([0,90,0])
	#cylinder(wallThickness+tolerance+50,wifiButtonDiameter/2,wifiButtonDiameter/2,true);

}


module hinge()
{
	translate([(lenseXOffset),wallThickness,cameraHeight/2+wallThickness])
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
		cylinder(hingeThickness*2+hingeGap+tolerance,hingeBoltDiameter/2,hingeBoltDiameter/2,true);
		}
	}
	
}
module case()
{
	difference()
	{
		cube([cameraLength+wallThickness*2,cameraWidth+wallThickness*2,cameraHeight+wallThickness*2],true);
		//translate([0,-wallThickness,0])

	
		usbPlugCutout();
		hero3();
		wifiButtonCutout();

	}
	//added geom for lense hole to avoid support material
	translate([lenseXOffset,cameraWidth/2,lenseZOffset])
	rotate([-90,0,0])
	cylinder(layerHeight,cameraLenseDiameter/2,cameraLenseDiameter/2);

	//LHS tab to attach back lid to
	translate([(cameraLength/2+wallThickness+tabDiameter/2),-(cameraWidth/2),0])
	{
		difference()
		{
			union()
			{
				rotate([90,0,0])
				cylinder(wallThickness*2,tabDiameter/2,tabDiameter/2,true);
				translate([-tabDiameter/4,0,0])
				cube([tabDiameter/2,wallThickness*2,tabDiameter],true);
			}

			//screw hole
			rotate([90,0,0])
			cylinder(wallThickness*2+tolerance,tabScrewDiameter/2,tabScrewDiameter/2,true);
		}
	}

	//RHS tab to attach back lid to
	translate([-(cameraLength/2+wallThickness+tabDiameter/2),-(cameraWidth/2),RHStabOffset])
	{
		rotate([0,180,0])
		{
			difference()
			{
				union()
				{
					rotate([90,0,0])
					cylinder(wallThickness*2,tabDiameter/2,tabDiameter/2,true);
					translate([-tabDiameter/4,0,0])
					cube([tabDiameter/2,wallThickness*2,tabDiameter],true);
				}

			//screw hole
			rotate([90,0,0])
			cylinder(wallThickness*2+tolerance,tabScrewDiameter/2,tabScrewDiameter/2,true);
			}
		}
	}
	
	//Bottom tab to attach back lid to
	translate([0,-(cameraWidth/2),-(cameraHeight/2+wallThickness+tabDiameter/2)])
	{
		rotate([0,90,0])
		{
			difference()
			{
				union()
				{
					rotate([90,0,0])
					#cylinder(wallThickness*2,tabDiameter/2,tabDiameter/2,true);
					translate([-tabDiameter/4,0,0])
					#cube([tabDiameter/2,wallThickness*2,tabDiameter],true);
				}

			//screw hole
			rotate([90,0,0])
			#cylinder(wallThickness*2+tolerance,tabScrewDiameter/2,tabScrewDiameter/2,true);
			}
		}
	}

}


module mountingBracket()
{

hingeOffset=(hingeDiameter-hingeDiameter*3/4)/2;
        difference()
        {
                //main shaft        
                translate([0,hingeOffset/2,-(bracketLength-hingeDiameter/2+bracketHoleSpacing/2+5)/2])
                cube([hingeThickness*4+hingeGap,hingeDiameter-hingeOffset,bracketLength-hingeDiameter/2+bracketHoleSpacing/2+5],true);
        
                //minus mounting screws
                translate([0,0,-(bracketLength-hingeDiameter/2+bracketHoleSpacing/2)])
                rotate([90,0,0])
                cylinder(hingeDiameter+tolerance,bracketScrewDiameter/2,bracketScrewDiameter/2,true);


                translate([0,0,-(bracketLength-hingeDiameter/2-bracketHoleSpacing/2)])
                rotate([90,0,0])
                cylinder(hingeDiameter+tolerance,bracketScrewDiameter/2,bracketScrewDiameter/2,true);


        }        


        difference()
        {
                union()
                {
                                //hinge cylinder middle
                                translate([0,0,hingeDiameter/2])        
                                rotate([0,90,0])
                                cylinder(hingeThickness,hingeDiameter/2,hingeDiameter/2,true);


                                //hinge cylinder bottombit middle
                                translate([0,hingeOffset/2,hingeDiameter/4])
                                cube([hingeThickness,hingeDiameter-hingeOffset,hingeDiameter/2],true);


                                //hinge cylinder RHS
                                translate([-(hingeThickness*2+(hingeGap-hingeThickness)/2),0,hingeDiameter/2])        
                                rotate([0,90,0])
                                cylinder(hingeThickness,hingeDiameter/2,hingeDiameter/2,true);


                                //hinge cylinder bottombit RHS
                                translate([-(hingeThickness*2+(hingeGap-hingeThickness)/2),hingeOffset/2,hingeDiameter/4])
                                cube([hingeThickness,hingeDiameter-hingeOffset,hingeDiameter/2],true);


                                //hinge cylinder LHS
                                translate([(hingeThickness*2+(hingeGap-hingeThickness)/2),0,hingeDiameter/2])        
                                rotate([0,90,0])
                                cylinder(hingeThickness,hingeDiameter/2,hingeDiameter/2,true);


                                //hinge cylinder bottombit LHS
                                translate([(hingeThickness*2+(hingeGap-hingeThickness)/2),hingeOffset/2,hingeDiameter/4])
                                cube([hingeThickness,hingeDiameter-hingeOffset,hingeDiameter/2],true);
                }
                //minus screw hole
                translate([0,0,hingeDiameter/2])
                rotate([0,90,0])
                cylinder(hingeThickness*4+hingeGap+tolerance,hingeBoltDiameter/2,hingeBoltDiameter/2,true);


        }//difference
}
module hinge()
{
        translate([(lenseXOffset),wallThickness,cameraHeight/2+wallThickness])
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
                cylinder(hingeThickness*2+hingeGap+tolerance,hingeBoltDiameter/2,hingeBoltDiameter/2,true);
                }
        }
        
}
module case()
{
        difference()
        {
                cube([cameraLength+wallThickness*2,cameraWidth+wallThickness*2,cameraHeight+wallThickness*2],true);
                translate([0,-wallThickness,0])


        
                usbPlugCutout();
                hero3();
						wifiButtonCutout();


        }
                //added geom for lense hole to avoid support material
        translate([lenseXOffset,cameraWidth/2,lenseZOffset])
        rotate([-90,0,0])
        cylinder(layerHeight,cameraLenseDiameter/2,cameraLenseDiameter/2);


        //LHS tab to attach back lid to
        translate([(cameraLength/2+wallThickness+tabDiameter/2),-(cameraWidth/2),0])
        {
                difference()
                {
                        union()
                        {
                                rotate([90,0,0])
                                cylinder(wallThickness*2,tabDiameter/2,tabDiameter/2,true);
                                translate([-tabDiameter/4,0,0])
                                cube([tabDiameter/2,wallThickness*2,tabDiameter],true);
                        }


                        //screw hole
                        rotate([90,0,0])
                        cylinder(wallThickness*2+tolerance,tabScrewDiameter/2,tabScrewDiameter/2,true);
                }
        }


        //RHS tab to attach back lid to
        translate([-(cameraLength/2+wallThickness+tabDiameter/2),-(cameraWidth/2),RHStabOffset])
        {
                rotate([0,180,0])
                {
                difference()
                {
                        union()
                        {
                                rotate([90,0,0])
                                cylinder(wallThickness*2,tabDiameter/2,tabDiameter/2,true);
                                translate([-tabDiameter/4,0,0])
                                cube([tabDiameter/2,wallThickness*2,tabDiameter],true);
                        }


                        //screw hole
                        rotate([90,0,0])
                        cylinder(wallThickness*2+tolerance,tabScrewDiameter/2,tabScrewDiameter/2,true);
                }
        }
}
        
        //Bottom tab to attach back lid to
        translate([0,-(cameraWidth/2),-(cameraHeight/2+wallThickness+tabDiameter/2)])
        {
                rotate([0,90,0])
                {
                difference()
                {
                        union()
                        {
                                rotate([90,0,0])
                                #cylinder(wallThickness*2,tabDiameter/2,tabDiameter/2,true);
                                translate([-tabDiameter/4,0,0])
                                #cube([tabDiameter/2,wallThickness*2,tabDiameter],true);
                        }


                        //screw hole
                        rotate([90,0,0])
                        #cylinder(wallThickness*2+tolerance,tabScrewDiameter/2,tabScrewDiameter/2,true);
                }
                }
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


module caseBackDoor()
{
	intersection()
	{
		case();
		translate([0,-(cameraWidth/2+wallThickness/2),0])
		cube([cameraLength+2*wallThickness+tabDiameter*2+tolerance,wallThickness+tolerance,cameraHeight+2*wallThickness+tabDiameter*2+tolerance],true);
	}
}

module caseFront()
{
	difference()
	{
		union()
		{
		case();
		hinge();
		}
		translate([0,-(cameraWidth/2+wallThickness/2),0])
		cube([cameraLength+2*wallThickness+tabDiameter*2,wallThickness+.0001,cameraHeight+2*wallThickness+tabDiameter*2],true);
	}
}

rotate([90,0,0])
mountingBracket();


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





//rotate([-90,0,0])
//mountingBracket();
case();
//wifiButtonCutout();
