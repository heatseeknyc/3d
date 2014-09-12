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
h = (25 + lip) * scaling;
w = 50 * scaling;
l = 55 * scaling;

// Values for interior space
h_pad = -1;
w_pad = 5;
l_pad = 5;


// The lid
h_lid = 2;
function hex_len(width) = 2 * (cos(30) * width);
hex_edge = edge_length(w/2);

translate([0,0,0]){
difference(){
union(){
cube([w, l, h_lid], center=true); // Center Cube
// The teeth

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

}}