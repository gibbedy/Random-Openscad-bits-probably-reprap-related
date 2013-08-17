		//elongated sphere to cut from bottom frame to allow topbit to rotate
		//need to find out a more efficient way to do this as it is very slow to render if
		//i increase iterations.
		
length=35;
width=35;


translate([width/2-7,0,0])cylinder(9,width/2-7,width/2-7);

rotate([0,20,0])translate([width/2-7,0,0])cylinder(9,width/2-7,width/2-7);