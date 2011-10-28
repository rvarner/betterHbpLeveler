
length = 10;
width = 22;
depth = .5;

x = 10;
y = 0;
z = 0;

module raft() {
	cube([length,width,depth],center=true);
}

module bracket() {
	import_stl("HBP_Leveler_Part1_A.stl",center = true);
}

union() {
	bracket();
	translate(v=[29.3,-22.8,depth/2]) raft();
}


