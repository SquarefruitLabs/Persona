$fn=30;

theta1 = 0;
theta2 = 0;

module base() {
	translate([0,0,-5]) {
		cylinder(r=6, h=5);
		rotate([90,0,90]) cylinder(r1 = 2, r2 = 0, h = 10);
	}
}
module j1() {
	cylinder(r=2, h=17);
}

module j2() {
	translate([0,0,17]) rotate([50,0,0]) {
		rotate([0,0,theta2]) {
			cylinder(r=2, h=10);
			translate([0,0,10]) rotate([90,0,90]) {
				cylinder(r1 = 2, r2 = 0, h = 10);
				translate([0,0,13]) cross();
			}
		}
	}
}

base();

rotate([0,0,theta1]) {
	j1();
	j2();
}

module cross() {
	rotate([90,0,90]) cylinder(r=0.5, h = 3, center = true);
	rotate([90,0,0]) cylinder(r=0.5, h = 3, center = true);
}

