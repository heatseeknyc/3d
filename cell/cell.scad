
$fn = 100;

// Functions for calculating the half-hexagons
function edge_length(width) = (width/2) / cos(30); // CAH
function point_height(width) = (width/2) * tan(30); // TOA
function leg(width) = edge_length(width) * sqrt(1/2);
function x_offset(width) = (width/2) - leg(width) * cos(15);
function y_offset(width, length) = length/2 - (leg(width) * sin(15));

// Core size variables
h = 33;
w = 60;
l = 90;

// Values for interior space
h_pad = 5;
w_pad = 5;
l_pad = 5;

difference(){
// The exterior shape
%union(){
cube([w, l, h], center=true); // Center Cube
translate([x_offset(w),-y_offset(w,l),0]){
	rotate([0,0,30]) cube([edge_length(w),edge_length(w),h], center=true);
}
translate([-x_offset(w),-y_offset(w,l),0]){
	rotate([0,0,-30]) cube([edge_length(w),edge_length(w),h], center=true);
}

translate([x_offset(w),y_offset(w,l),0]){
	rotate([0,0,-30]) cube([edge_length(w),edge_length(w),h], center=true);
}
translate([-x_offset(w),y_offset(w,l),0]){
	rotate([0,0,30]) cube([edge_length(w),edge_length(w),h], center=true);
}}

// The interior shape
translate([0,0,0]){
union(){
cube([w-w_pad, l-l_pad, h-h_pad], center=true); // Center Cube
translate([x_offset(w-w_pad),-y_offset(w-w_pad,l-l_pad),0]){
	rotate([0,0,30]) cube([edge_length(w-w_pad),edge_length(w-w_pad),h-h_pad], center=true);
}
translate([-x_offset(w-w_pad),-y_offset(w-w_pad,l-l_pad),0]){
	rotate([0,0,-30]) cube([edge_length(w-w_pad),edge_length(w-w_pad),h-h_pad], center=true);
}

translate([x_offset(w-w_pad),y_offset(w-w_pad,l-l_pad),0]){
	rotate([0,0,-30]) cube([edge_length(w-w_pad),edge_length(w-w_pad),h-h_pad], center=true);
}
translate([-x_offset(w-w_pad),y_offset(w-w_pad,l-l_pad),0]){
	rotate([0,0,30]) cube([edge_length(w-w_pad),edge_length(w-w_pad),h-h_pad], center=true);
}}}}


// The lid
h_lid = 3;
function hex_len(width) = 2 * (cos(30) * width);
hex_edge = edge_length(w/1.6);

translate([0,0,40]){
difference(){
union(){
cube([w, l, h_lid], center=true); // Center Cube
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
translate([0,0,2]){
union(){
	rotate([0,0,0]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
	rotate([0,0,60]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
	rotate([0,0,120]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
}}}}