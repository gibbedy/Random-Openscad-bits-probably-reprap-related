//To hold my transmitter in it's case
tolerance=.001;
$fn=100;
bracketDiameter=5;
DHUWidth=27;
DHUDiameter=10;
DHUHeight=5;
wallThickness=5;
baseHeight=bracketDiameter+DHUHeight+wallThickness;
width=bracketDiameter+2*wallThickness;
//length must be less than 83mm
length=83;
overhangCylinder=length;
screwDiameter=3;
screwCenters=length-23;

module bracket()
{
difference()
{
union()
{
//base
translate([0,0,-bracketDiameter/2])
cube([length,width,baseHeight],true);

}
translate([0,0,baseHeight/2-DHUHeight/2])
//DHUBracket cutout
cube([DHUWidth,width+tolerance,baseHeight],true);
rotate([0,90,0])
{
//bit for DHT-U mount to slot in
cylinder(DHUWidth,DHUDiameter/2,DHUDiameter/2,true);
//center cylinder cutout
cylinder(length+tolerance,bracketDiameter/2,bracketDiameter/2,true);
//slot slighly smaller than bracketDiameter
}
translate([0,0,(bracketDiameter/2+wallThickness)/2+tolerance])
cube([length+tolerance,bracketDiameter-.5,bracketDiameter/2+wallThickness+tolerance],true);

//screw holes
translate([screwCenters/2,0,0])
cylinder(baseHeight+bracketDiameter,screwDiameter/2,screwDiameter/2,true);

//screw holes
translate([-screwCenters/2,0,0])
cylinder(baseHeight+bracketDiameter,screwDiameter/2,screwDiameter/2,true);

//fillet edge for printing in strongest orientation
difference()
{
translate([0,0,overhangCylinder/2-DHUDiameter/2])
rotate([90,0,0])
#cylinder(width+tolerance,overhangCylinder/2,overhangCylinder/2,true);

translate([0,0,-DHUDiameter/2-baseHeight/2])
#cube([length,width,baseHeight],true);
}
}
}
rotate([0,90,0])
bracket();