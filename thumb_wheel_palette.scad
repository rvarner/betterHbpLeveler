
// Pallet for thumb wheels

module buildPlatform() {
	translate(v=[0,0,-1]) cube([100,100,2],center=true);
}

module thumbWheel() {
	import_stl("HBP_Thumb_Wheel.stl");
}

//buildPlatform();
translate(v=[-25,-25,0]) thumbWheel();
translate(v=[-25,0,0]) thumbWheel();
translate(v=[25,-25,0]) thumbWheel();
translate(v=[0,-25,0]) thumbWheel();
translate(v=[-25,25,0]) thumbWheel(); 
translate(v=[0,25,0]) thumbWheel(); 
translate(v=[25,25,0]) thumbWheel();
translate(v=[25,0,0]) thumbWheel();