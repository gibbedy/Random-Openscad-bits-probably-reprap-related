//pan and tilt mount for antenna tracker.

tiltBaseDiameter=20;
wallThickness=5;
//Tilt servo HS-645MG Dimensions
servoLength=40.6;
servoWidth=19.8;
servoHeight=37.8;
servoTabLength=53.4;
servoMountHoleCentersWidth=10.2;
servoMountHoleCentersLength=48.4;
servoBelowTabHeight=27;
servoTabHeight=3.5;
servoMountHoleDiameter=4;
servoWheelOffset=9.5;
servoWheelHeightOffset=6.5;
servoWheelDiameter=24;
servoWheelWidth=2;

module tiltServo()
{
	
	//main cube
	cube([servoLength,servoWidth,servoHeight],true);
	//tab
	difference()
	{
		translate([0,0,servoTabHeight/2+(servoHeight-servoBelowTabHeight)/2])
		cube([servoTabLength,servoWidth,servoTabHeight],true);

		translate([servoMountHoleCentersLength/2,servoMountHoleCentersWidth/2,servoTabHeight/2+(servoHeight-servoBelowTabHeight)/2])
		cylinder(servoTabHeight,servoMountHoleDiameter/2,servoMountHoleDiameter/2,true);

		translate([-servoMountHoleCentersLength/2,servoMountHoleCentersWidth/2,servoTabHeight/2+(servoHeight-servoBelowTabHeight)/2])
		cylinder(servoTabHeight,servoMountHoleDiameter/2,servoMountHoleDiameter/2,true);

		translate([servoMountHoleCentersLength/2,-servoMountHoleCentersWidth/2,servoTabHeight/2+(servoHeight-servoBelowTabHeight)/2])
		cylinder(servoTabHeight,servoMountHoleDiameter/2,servoMountHoleDiameter/2,true);

		translate([-servoMountHoleCentersLength/2,-servoMountHoleCentersWidth/2,servoTabHeight/2+(servoHeight-servoBelowTabHeight)/2])
		cylinder(servoTabHeight,servoMountHoleDiameter/2,servoMountHoleDiameter/2,true);
	}
	
	//servoWheel positioned relative to top of wheel
	translate([servoLength/2-servoWheelOffset,0,servoHeight/2+servoWheelHeightOffset+servoWheelWidth/2])
	cylinder(servoWheelWidth,servoWheelDiameter/2,servoWheelDiameter/2,true);
}

module tiltTop()
{
	translate([-servoLength/2+servoWheelOffset,
	,0])
	cube([servoLength+wallThickness*2,servoBelowTabHeight,servoWidth+wallThickness*2],true);
	//servo positioned
	rotate([90,0,0])
	translate([-servoLength/2+servoWheelOffset,0,-servoHeight/2-servoWheelHeightOffset-servoWheelWidth])
	tiltServo();
}

tiltTop();