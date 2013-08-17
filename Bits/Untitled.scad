translate([0,-5,0])rotate([90,0,0])cylinder(5,10,10,true);
translate([0,-10,25])rotate([0,90,0])cylinder(25,1,1,true);

translate([0-0,-5--10,0-25])rotate([90,0,0])cylinder(5,10,10,true);

module rotateAboutAxis(vectorOfObjectToRotate,vectorOfRotationAxis,angle)
{
	origin=vectorOfObjectToRotate-vectorOfRotationAxis;
}

echo ([1,2,3]-[4,5,6]);