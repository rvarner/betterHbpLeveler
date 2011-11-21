
length = 10;
width = 22;
depth = .5;

boltHeadDiameter = 5.43;
boltHeadDepth = 1.75;
boltHeadFn = 60;

boltThreadsDiameter = 3.2;
hole1 = [-27.6,28.4,0];
holePin1 = [-27.6,28.4,2.5];
hole2 = [-17.1,28.4,0];
holePin2 = [-17.1,28.4,2.5];
holePinHeight = 50;
hole1InsetVector = hole1;
hole2InsetVector = hole2;
coasterHeight = 1;
holeOffset = 2.5;
coasterOffest = hole1 + [0,0,holeOffset];
x = 10;
y = 0;
z = 0;

module raft() {
	cube([length,width,depth],center=true);
}

module bracket() {
	import_stl("HBP_Leveler_Part1_A.stl",center = true);
}


module boltHead() {
	translate(v= [0,0,boltHeadDepth/2]) cylinder(h = boltHeadDepth, r = boltHeadDiameter/2,center = true,$fn=boltHeadFn);
}

module biggerBoltHead() {
	translate(v= [0,0,boltHeadDepth/2]) cylinder(h = boltHeadDepth, r = (boltHeadDiameter/2)+1,center = true,$fn=boltHeadFn);
}

module thinVerticalLine() {
	cylinder(h=30,r=boltThreadsDiameter/2,center=true,$fn=20);
}

module raftedBracket() {
	union() {
		bracket();
		translate(v=[29.3,-22.8,depth/2]) raft();
	}
}

module coaster() {
	translate(v= -1 * coasterOffest) difference() {
		translate(v=coasterOffest) cylinder(h=coasterHeight,r=(boltThreadsDiameter/2)+1,center=true,$fn=boltHeadFn);
		bracket();
	}
}

module holePin() {
	scale(v=[1,1,holePinHeight-coasterHeight]) coaster();
}

module pluggedHoleBracket() {
	union() {
		raftedBracket();
		translate(v=hole1) biggerBoltHead();
		translate(v=hole2) biggerBoltHead();
	}
}
module boxHeadInsets() {
	union() {
		difference() {
			pluggedHoleBracket();
			translate(v=hole1) boltHead();
			translate(v=hole2) boltHead();
		}
		translate(v=hole1) insetSupportMaterial();
		translate(v=hole2) insetSupportMaterial();
	}
}

module insetSupportMaterial() {
	intersection() {
		cylinder(h=10,r=2.5,center=true,$fn=boltHeadFn);
		nutCylinder();
	}
}


module main() {
//	union()  {
		difference() {
			boxHeadInsets();
			translate(v=hole1) holePin();
			translate(v=hole2) holePin();
		}
//		finalNutColumn();
//	}
}



//color([255,0,0]) {boltHead();}
//translate(v=[-17,-17,4.61]) boltHead();
nutDepth = 2.3;
magBoltHeight = 4.62;
magBoltVector = [-17,-17,4.62];
centerMagBoltColumn = [0,0,4.62] - magBoltVector;
magBoltHeight = 50;
magBoltDiameter = 8;

module magneticBoltColumn() {
	translate(v= centerMagBoltColumn ) intersection() {
		translate(v=magBoltVector + [0,0,(-magBoltHeight/2) +boltHeadDepth ] ) cylinder(h=magBoltHeight,r=magBoltDiameter/2,center=true, $fn=boltHeadFn);
		bracket();
	}
}

module nutCylinder() {
	intersection() {
		translate(v = [0,0,nutDepth/2]) cylinder(h=nutDepth, r=magBoltDiameter/2,center=true,$fn=boltHeadFn);
		magneticBoltColumn();
	}
}



module topNutColumn() {
	intersection() {
		translate(v=[0,0,6]) translate(v=[0,0,0.5])cylinder(h=1, r = magBoltDiameter/2,center=true,$fn=boltHeadFn);
		magneticBoltColumn();
	}
}



module solidNutColumn() {
	union() {
		topNutColumn();
		union() {
			translate(v=[0,0,-1]) topNutColumn();
			union() {
				translate(v=[0,0,-2]) topNutColumn();
				union() {
					translate(v=[0,0,-2]) topNutColumn();
					union() {
						translate(v=[0,0,-3]) topNutColumn();
						union() {
							translate(v=[0,0,-4]) topNutColumn();
							union() {
								translate(v=[0,0,-5]) topNutColumn();
								translate(v=[0,0,-6]) topNutColumn();
							}
						}
					}
				}
			}
		}	
	}

	
}


module finalNutColumn(){
	translate(v=[-17,-17,0])  union() {
		difference() {
			solidNutColumn();
			translate(v=[0,0,nutDepth/2]) cylinder(h=nutDepth,r=magBoltDiameter/2,center=true,$fn=boltHeadFn);
		}
		nutCylinder();		
	}
}

//difference() {
//	main();
//	translate(v=magBoltVector) boltHead();
//}




main();
