//Extrusion width used when printing
extrusionWidth=.7;


screwDiameter=3.5;

//plug1 dimensions 
plug1Height=7.5;
plug1WidthTop=17;
plug1WidthBottom=15;
plate1Height=13;
plate1Width=31;
plate1Thickness=1;
//plug2 dimensions
plug2Height=9.5;
plug2WidthTop=18;
plug2WidthBottom=17;
plate2Height=13;
plate2Width=31;


module mainBit()
{
//main frame
cube([max(plate1Width,plate2Width),
max(plate1Width,plate2Width),
max(plate1Height,plate2Height)+6*extrusionWidth],true);


}

//mainBit();

module plugCutout()
{
//plug cutout
rotate([90,0,0])
translate([-plug1WidthTop/2,-plug1Height/2,-(plate1Width+10)/2])
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
translate([0,-(plate1Width/2-extrusionWidth),0])
cube([plate1Width,plate1Thickness,plate1Height],true);

translate([0,(plate1Width/2-extrusionWidth),0])
cube([plate1Width,plate1Thickness,plate1Height],true);
}

module screwHoles()
{

	translate([(max(plate1Width,plate2Width)/2-screwDiameter),0,0])
	cylinder(max(plate1Height,plate2Height)+6*extrusionWidth,
	screwDiameter/2,screwDiameter/2,true);

	translate([-(max(plate1Width,plate2Width)/2-screwDiameter),0,0])
	cylinder(max(plate1Height,plate2Height)+6*extrusionWidth,
	screwDiameter/2,screwDiameter/2,true);
}



//put it all together
difference()
{
mainBit();
plugCutout();
plates();
screwHoles();
}




