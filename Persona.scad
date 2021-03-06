/*
Squarefruit Labs - Persona
*/

use <arrows.scad>;
//Arm lengths
arm1 = 100;
arm2 = 80;

//Set arrows' visibility
showArrows = false;

//Offset between the base and arm
baseoff = 50;
//Offset between the upper and lower arm
elboff = 20;

//Render resolution. 
//Number of (linear) segments a circle is divided into. 
resolution = 40;

off = baseoff + elboff;


//Target x,y,z coordinates
x = 0;
y = 150;
z = 0;

//Distance from the origin to the point. 
//Verify the target is within bounds
totdist = sqrt(pow(x,2)+pow(y,2)+pow(z,2));
echo("totdist",totdist);

//converting to cylindrical coordinates
rad2 = sqrt(pow(x,2)+pow(y,2));
//height
hgt = z;
//Angle
phi = atan2(y,x);

//Corresponding angle the base needs to rotate
corrangl = atan2(off, rad2);
//Corrected radius to account for offsets
corrrad = sqrt(off*off+rad2*rad2) - rad2;
echo("corr",corrrad,rad2);

//Proper targets in the robot's frame
targetx = x - corrrad*cos(phi);
targety = y - corrrad*sin(phi);
targetz = z;

//Corrected radius for the targets
rad = sqrt(targetx*targetx + targety*targety);


echo("targ", targetx, targety, targetz);
echo("xyz", x,y,z);

cyldist = sqrt(pow(rad,2)+pow(hgt,2));
echo("cyldist", cyldist);

//S,Q,E - pseudo SCARA arm parameters
kyu = acos((pow(rad,2)+pow(hgt,2)+pow(arm1,2)-pow(arm2,2))/(2*arm1*sqrt(pow(rad,2)+pow(hgt,2))));
eee = acos((pow(rad,2)+pow(hgt,2)-pow(arm1,2)-pow(arm2,2))/(2*arm1*arm2));
ess = -atan2(hgt, rad) - kyu;

echo("SE", ess, eee);

//Upper arm, assuming the ball is the shoulder
module arm_one()
{
	color("cyan")translate([0,baseoff,0])hull()
	{
		sphere(r=8,$fn = resolution);
		translate([arm1,0,0]) sphere(r=8, $fn=resolution);
	}
	if(showArrows) translate([0,baseoff,0])rotate([90,90,0])arrow(20,"red");
	if(showArrows) translate([arm1/2,baseoff,0])rotate([-90,0,90])arrow(20,"green");
}

//Fore arm
module arm_two()
{
	color("cyan") translate([0,baseoff + elboff,0]) hull()
	{
		sphere(r=8, $fn=resolution);
		translate([arm2,0,0]) sphere(r=8, $fn= resolution);
	}
	translate([arm2, baseoff + elboff, 0]) rotate([0,-ess,0]) rotate([0,-eee,0])endEff();
	if(showArrows) translate([0,off,0])rotate([90,90,0])arrow(20,"red");
	if(showArrows) translate([arm2/2,off,0])rotate([-90,0,0])rotate([0,90,0])arrow(20, "green");
}

translate([0,0,30])//color("cyan",0.6)
{
	rotate([0,0,phi - corrangl]) rotate([0,ess,0]) arm_one();
	rotate([0,0,phi - corrangl]) rotate([0,ess,0]) translate([arm1, 0,0]) rotate([0,eee,0]) arm_two();
}

//Testing purposes only, to mark the final position.
module vector()
{
	hull()
	{
		sphere(r=2);
		translate([x,y,z]) sphere(r=2);
	}
}
//color("red") vector();

module endEff()
{
	
	color("cyan") hull()
	{
		sphere(r=8);
		translate([0,0,-15]) sphere(r=2);
	}
	if(showArrows) translate([0,0,-10])rotate([90,0,0])arrow(20,"red");
}


//translate([targetx, targety, targetz]) endEff();
//For debugging - outputs in the console
module calc_rotation(x,y,arm_num)
{
	rot = acos((pow(x,2)+pow(y,2)+pow(arm1,2)-pow(arm2,2))/(2*arm1*sqrt(pow(x,2)+pow(y,2))));
	echo(arm_num, rot);
}

//End effector
module base()
{
	color("cyan") difference()
	{
	minkowski()
	{
	sphere(r = 35, center = true, $fn=resolution);
	sphere(r = 5, center = true, $fn=resolution);
	}
	translate([0,0,-70])cube([80,80,80], center = true);
	}
	
	
}
if(showArrows) translate([0,0,-10]) arrow(20, "red");
color("cyan")translate([0,0,30])base();
