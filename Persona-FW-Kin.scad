use <Persona.scad>


/*
Algorithm:

Set home position 
	base_rotation=0;
	arm1_rot=o;
	arm2_rot=0;
Compute angles
Convert to number of steps
Send out steps to move

*/



home = [0,0,0];
full_up = [0,0,180];
test1 = [45, 45, 90];
test2 = [0, 90, 180];
test3 = [30, 60, 120];


pos = test3;


base_rotation = pos[0];
arm1_rot = pos[1];
arm2_rot = pos[2];

arm1 = 100;
arm2 = 80;
totOff = 70;

rotate([0,0,-base_rotation])
{
	base();
	rotate([0,-90 + arm1_rot,0])
		{
		arm_one();
		translate([arm1,0,0]) rotate([0,180-arm2_rot,0])
			{
				arm_two();
				translate([arm2, totOff,0])rotate([0,-90 + arm2_rot-arm1_rot,0])endEff();
			}
		}
}