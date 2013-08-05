//This is my attempt to model a Tap.


//Create a tap by specifying size of square, length of square, shank length, thread length
module Tap(diameter,sqrSize,sqrLength,shankLength,threadLength)
	{
	echo("********************************************");
	echo("Creating tap with following dimensions");
	echo("Diameter: ",diameter);
	echo("Square size: ",sqrSize);
	echo("Square length: ",sqrLength);
	echo("Shank Length: ",shankLength);
	echo("Thread Length: ",threadLength);
	echo("********************************************");

	//square key
	translate([-sqrSize/2,-sqrSize/2,0]) cube([sqrSize,sqrSize,sqrLength]);
	
	//shank
	translate([0,0,sqrLength])cylinder(shankLength,diameter/2,diameter/2);

	//thread
	translate([0,0,sqrLength+shankLength])cylinder(threadLength,diameter/2,diameter/2);

	}

//Parameters ***********************************

//tap diameter
diameter=4;

//Square Size
sqrSize=3.1;

//square length
sqrLength=8;

//Shank length
shankLength=23;

//depth of head
threadLength=24;

//**********************************************

Tap(diameter,sqrSize,sqrLength,shankLength,threadLength);





