$fn = 100;
module arrow(out_rad, arr_color) {
	in_rad = 10/13*out_rad;
	thickness = 4/13*out_rad;
	color(arr_color) 
	union() {
	difference()
	{
		cylinder(r=out_rad, h=1.1*thickness, center=true);
		union() {
			cylinder(r=in_rad, h=1.2*thickness, center=true);
			translate([-1.2*out_rad, 0, -0.6*thickness]) cube([2.4*out_rad, 2.4*out_rad, 1.2*thickness]);
		}
		
	}
	intersection() {
		rotate([0,0,90])translate([0,out_rad,0])rotate([90,0,0])cylinder(r=0.4*out_rad, h=out_rad, $fn=3, center=true);
		difference() {
		cylinder(r=out_rad, h=3*thickness, center=true);
		cylinder(r=in_rad, h=3.1*thickness, center=true);
		}
	}
	mirror([1,0,0])intersection() {
		rotate([0,0,90])translate([0,out_rad,0])rotate([90,0,0])cylinder(r=0.4*out_rad, h=out_rad, $fn=3, center=true);
		difference() {
		cylinder(r=out_rad, h=3*thickness, center=true);
		cylinder(r=in_rad, h=3.1*thickness, center=true);
		}
	}
}
}
arrow(10,"red");


