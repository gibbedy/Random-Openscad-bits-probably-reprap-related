//Test to see how to use OO style code.

//I create the code once to create a bearing given any number of parameters
//This could be complex
module Bearing(diameter)
	{
	cylinder(5,diameter,diameter);
	}

//I create my specific bearing I want to use.
//I'm thinking the advantage is I can create multiple 
//bearings without repeating code in 'Parent' Bearing()
module bearing_I_Want_to_Use()
	{
	Bearing(13);
	}


//I want to model something that uses this bearing and access that bearings
//diameter maybe to do some translation. eg replace 1 with bearing_I_Want_to_Use diameter

difference()
	{
	translate([1,0,30])cube(60,true);
	bearing_I_Want_to_Use();
	}

