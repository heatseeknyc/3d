$fn = 100; // Set circles to high-precision

// Functions for calculating the half-hexagons
function edge_length(width) = (width/2) / cos(30); // CAH
function point_height(width) = (width/2) * tan(30); // TOA
function leg(width) = edge_length(width) * sqrt(1/2);
function x_offset(width) = (width/2) - leg(width) * cos(15);
function y_offset(width, length) = length/2 - (leg(width) * sin(15));

// Function for the hexagon cutout
function hex_len(width) = 2 * (cos(30) * width);


// Core size variables
h = 33;
w = 60;
l = 90;

// Values for interior space
h_pad = 4;
w_pad = 4;
l_pad = 5;

// The hexagon cutout
h_cutout = 3;
hex_edge = edge_length(w/1.6);

rotate([-90,00,0]){
	difference(){
		// The exterior shape
		union(){
			cube([w+w_pad, l+l_pad, h+h_pad], center=true); // Center Cube
			translate([x_offset(w+w_pad),-y_offset(w+w_pad,l+l_pad),0]){
				rotate([0,0,30]) cube([edge_length(w+w_pad),edge_length(w+w_pad),h+h_pad], center=true);
			}
			translate([-x_offset(w+w_pad),-y_offset(w+w_pad,l+l_pad),0]){
				rotate([0,0,-30]) cube([edge_length(w+w_pad),edge_length(w+w_pad),h+h_pad], center=true);
			}
		}

		// The interior shape
		translate([0,0,0]){
			union(){
				cube([w, l, h], center=true); // Center Cube
				translate([x_offset(w),-y_offset(w,l),0]){
					rotate([0,0,30]) cube([edge_length(w),edge_length(w),h], center=true);
				}
				translate([-x_offset(w),-y_offset(w,l),0]){
					rotate([0,0,-30]) cube([edge_length(w),edge_length(w),h], center=true);
				}
				translate([0,y_offset(w,l),0]){
					rotate([0,0,0]) cube([w,edge_length(w),h], center=true);
				}
				rotate([0,90,0]) cylinder(100, r=4, center=true);
			}
		}
	}
}