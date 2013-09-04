use <..\Bolt.scad>
$fn=50;

//Extrusion width used when printing
extrusionWidth=.7;


screwDiameter=3.5;

//plug1 dimensions 
plug1Height=11;
plug1WidthTop=17.5;
plug1WidthBottom=19.5;
plate1Height=13;
plate1Width=31;
plate1Thickness=1.25;
//plug2 dimensions
plug2Height=11;
plug2WidthTop=17.5;
plug2WidthBottom=19.5;
plate2Height=13;
plate2Width=31.5;


module mainBit()
{
//main frame
cube([max(plate1Width,plate2Width)+4*extrusionWidth,
max(plate1Width,plate2Width),
max(plate1Height,plate2Height)+6*extrusionWidth],true);


}


module plugCutout()
{
//plug cutout
rotate([90,0,0])
translate([-plug1WidthBottom/2,-plug1Height/2,-(plate1Width+10)/2])
{
linear_extrude(height = plate1Width+10)
polygon(points=[[0,0],
[plug1WidthBottom,0],
[plug1WidthBottom-(plug1WidthBottom-plug1WidthTop)/2,plug1Height],
[(plug1WidthBottom-plug1WidthTop)/2,plug1Height]]);
}
}

module plates() 
{
//plates
translate([0,-(plate1Width/2-2*extrusionWidth-plate1Thickness/2),0])
cube([plate1Width,plate1Thickness,plate1Height],true);

translate([0,(plate1Width/2-2*extrusionWidth-plate1Thickness/2),0])
cube([plate1Width,plate1Thickness,plate1Height],true);
}

module screwHoles()
{

	translate([(max(plate1Width,plate2Width)/2-screwDiameter),0,0])
	{	
	cylinder(max(plate1Height,plate2Height)+6*extrusionWidth,
	screwDiameter/2,screwDiameter/2,true);	
	translate([0,0,-(max(plate1Height,plate2Height)+6*extrusionWidth)/2])
	nut(7,5);
	translate([0,0,(max(plate1Height,plate2Height)+6*extrusionWidth)/2])
	cylinder(5,3.5,3.5,true);
	}

	translate([-(max(plate1Width,plate2Width)/2-screwDiameter),0,0])
	{
	cylinder(max(plate1Height,plate2Height)+6*extrusionWidth,
	screwDiameter/2,screwDiameter/2,true);
	translate([0,0,(max(plate1Height,plate2Height)+6*extrusionWidth)/2])
	nut(7,5);
	translate([0,0,-(max(plate1Height,plate2Height)+6*extrusionWidth)/2])
	cylinder(5,3.5,3.5,true);
	}
}



//put it all together
module putTogether()
{
difference()
{
mainBit();
plugCutout();
plates();
screwHoles();
}
}

//screwHoles();
//putTogether();

module plate()
{
//arrange plate
rotate([180,0,0])
{
//top half
translate([0,32,0])
rotate([180,0,0])
intersection()
{
putTogether();
translate([0,0,(max(plate1Height,plate2Height)+6*extrusionWidth)/2])
cube([max(plate1Width,plate2Width)+10,
max(plate1Width,plate2Width)+10,
max(plate1Height,plate2Height)+6*extrusionWidth],true);
}

//bottom half
intersection()
{
putTogether();
translate([0,0,-(max(plate1Height,plate2Height)+6*extrusionWidth)/2])
cube([max(plate1Width,plate2Width)+10,
max(plate1Width,plate2Width),
max(plate1Height,plate2Height)+6*extrusionWidth],true);
}
}
}
plate();

