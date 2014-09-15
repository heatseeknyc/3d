$fn = 100;

// Functions for calculating the half-hexagons
function edge_length(width) = (width/2) / cos(30); // CAH
function point_height(width) = (width/2) * tan(30); // TOA
function leg(width) = edge_length(width) * sqrt(1/2);
function x_offset(width) = (width/2) - (leg(width) * cos(15));
function y_offset(width, length) = (length/2) - (leg(width) * sin(15));

//function x_offset2(width) = (width/2) + (leg(width) * sin(15));
function y_offset2(width, length) = (length/2) + (leg(width) * cos(15)) - point_height(w) + 2; // +2 is arbitrary, should fix.

// Core size variables
scaling = 1;
h = (35) * scaling;
w = (65) * scaling;
l = (90 + point_height(w)) * scaling;// 90 = Pi

// Values for wall thickness
w_pad = 3;
l_pad = 3;
h_pad = 1.5;

W = w + w_pad;
L = l + l_pad;
H = h + h_pad;
btm = W*0.9; // The ratio of the bottom cutout to overall width

difference(){ // Between the exterior and interior
// The exterior shape
	difference(){ // For the btm (bottom) cutout
		union(){
			cube([W, L, H], center=true); // Center Cube
			translate([x_offset(W),y_offset(W,L),0]){
				rotate([0,0,-30]) cube([edge_length(W),edge_length(W),H], center=true);
			}
			translate([-x_offset(W),y_offset(W,L),0]){
				rotate([0,0,30]) cube([edge_length(W),edge_length(W),H], center=true);
			}
		}
		translate([-x_offset(btm),-y_offset2(btm,L),0]){
			rotate([0,0,30]) cube([edge_length(btm),edge_length(btm),H], center=true);
		}
		translate([x_offset(btm),-y_offset2(btm,L),0]){
			rotate([0,0,-30]) cube([edge_length(btm),edge_length(btm),H], center=true);
		}
	}

	// The interior cutout
	translate([0,0,h_pad+.01]){
		union(){
			translate([0,point_height(w)/2,0]){
				cube([w, l - point_height(w), h], center=true); // Center Cube
			}
			translate([x_offset(w),y_offset(w,l),0]){
				rotate([0,0,-30]) cube([edge_length(w),edge_length(w),h], center=true);
			}
			translate([-x_offset(w),y_offset(w,l),0]){
				rotate([0,0,30]) cube([edge_length(w),edge_length(w),h], center=true);
			}
			translate([-w/3,-l/4,0]){
				difference(){
					rotate([0,0,30]){
						cube([w, w/2, h], center=true);
					}
					translate([-w/3,0,0]){
						cube([w/3, w, h], center=true);
					}
				}
			}
			translate([w/3,-l/4,0]){
				difference(){
					rotate([0,0,-30]){
						cube([w, w/2, h], center=true);
					}
					translate([w/3,0,0]){
						cube([w/3, w, h], center=true);
					}
				}
			}
		}
	}
	translate([w/2,-(l-point_height(w))/3,(-h/3)+3]){cube([20, 9, 5], center=true);} // Charger hole
	#translate([-w/5,(l+point_height(w))/2,0]){cube([35, 30, 18], center=true);} // Dongle hole
	translate([-W/2.15,0,h/2]){cube([3, 6, 10], center=true);} // Lid grooves
	translate([W/2.15,0,h/2]){cube([3, 6, 10], center=true);}
}
