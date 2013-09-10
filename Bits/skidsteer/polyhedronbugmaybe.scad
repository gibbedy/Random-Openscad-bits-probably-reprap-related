//wird polyhedron bug?
//I think a warning would be good telling me I didn't use all points on connecting faces
//in first polyhedron


difference()
{

//create a cube using polyhedron with 6 points for bottom and only 4 points for top
//this causes buggy behaviour. rendering with an intersecting object causes polyhedron to 
//dissapear. 
//Rendered here with cube cutout shows hollow shell 
polyhedron(

points=[[0,0,0],[1,0,0],[0,1,0],[1,1,0],[0,2,0],[1,2,0],[0,0,1],[1,0,1],[0,2,1],[1,2,1]],
triangles=[[0,1,2],[1,3,2],[2,3,4],[3,5,4,],[4,5,8],[5,9,8],[8,9,7],[8,7,6],[6,7,0],[0,7,1],
				[0,8,6],[0,4,8], //lhs made using only 4 points located on face
				[1,7,9],[1,9,5]]); //rhs made using only 4 points located on face

//difference a cube
cube(1,true);
}



//fixed example using all points for sides
translate([2,0,0])
{

	difference()
	{
	polyhedron(

	points=[[0,0,0],[1,0,0],[0,1,0],[1,1,0],[0,2,0],[1,2,0],[0,0,1],[1,0,1],[0,2,1],[1,2,1]],
	triangles=[[0,1,2],[1,3,2],[2,3,4],[3,5,4,],[4,5,8],[5,9,8],[8,9,7],[8,7,6],[6,7,0],[0,7,1],
				[0,2,6],[2,8,6],[2,4,8], //lhs made with all 5 points located on face 
				[1,7,3],[3,7,9],[3,9,5]]); //rhs made with all 5 point located on face

	cube(1,true);
	}
}
