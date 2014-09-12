$fn = 100;

// Functions for calculating the half-hexagons
function edge_length(width) = (width/2) / cos(30); // CAH
function point_height(width) = (width/2) * tan(30); // TOA
function leg(width) = edge_length(width) * sqrt(1/2);
function x_offset(width) = (width/2) - leg(width) * cos(15);
function y_offset(width, length) = length/2 - (leg(width) * sin(15));

// Core size variables
scaling = 1;
lip = 0;
h = (35 + lip) * scaling;
w = 65 * scaling;
l = 70 * scaling;

// Values for interior space
h_pad = -1;
w_pad = 5;
l_pad = 5;


// The lid
h_lid = 3;
function hex_len(width) = 2 * (cos(30) * width);
hex_edge = edge_length(w/2);

translate([0,0,0]){
difference(){
union(){
cube([w, l, h_lid], center=true); // Center Cube
translate([-w/2.2,0,-h_lid*1.5]){cube([1.5, 5, 8], center=true);} // The teeth
translate([w/2.2,0,-h_lid*1.5]){cube([1.5, 5, 8], center=true);}
translate([x_offset(w),-y_offset(w,l),0]){
	rotate([0,0,30]) cube([edge_length(w),edge_length(w),h_lid], center=true);
}
translate([-x_offset(w),-y_offset(w,l),0]){
	rotate([0,0,-30]) cube([edge_length(w),edge_length(w),h_lid], center=true);
}

translate([x_offset(w),y_offset(w,l),0]){
	rotate([0,0,-30]) cube([edge_length(w),edge_length(w),h_lid], center=true);
}
translate([-x_offset(w),y_offset(w,l),0]){
	rotate([0,0,30]) cube([edge_length(w),edge_length(w),h_lid], center=true);
}}

// The cutout
translate([0,0,0]){
union(){
	rotate([0,0,0]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
	rotate([0,0,60]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
	rotate([0,0,120]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
}}}}