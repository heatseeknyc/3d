$fn = 100;

// Functions for calculating the half-hexagons
function edge_length(width) = (width/2) / cos(30); // CAH
function point_height(width) = (width/2) * tan(30); // TOA
function leg(width) = edge_length(width) * sqrt(1/2);
function x_offset(width) = (width/2) - leg(width) * cos(15);
function y_offset(width, length) = length/2 - (leg(width) * sin(15));

// Core size variables
scaling = 1;
h = (35) * scaling;
w = (55) * scaling;
l = (85) * scaling;

// Values for interior space
h_pad = 2;
w_pad = 4;
l_pad = 4;


// The lid
h_lid = 1;
function hex_len(width) = 2 * (cos(30) * width);
hex_edge = edge_length(w/2);

translate([0,0,0]){
difference(){
union(){
cube([w+w_pad, l+l_pad, h_lid], center=true); // Center Cube
// The teeth

translate([x_offset(w+w_pad),-y_offset(w+w_pad,l+l_pad),0]){
	rotate([0,0,30]) cube([edge_length(w+w_pad),edge_length(w+w_pad),h_lid], center=true);
}
translate([-x_offset(w+w_pad),-y_offset(w+w_pad,l+l_pad),0]){
	rotate([0,0,-30]) cube([edge_length(w+w_pad),edge_length(w+w_pad),h_lid], center=true);
}

translate([x_offset(w+w_pad),y_offset(w+w_pad,l+l_pad),0]){
	rotate([0,0,-30]) cube([edge_length(w+w_pad),edge_length(w+w_pad),h_lid], center=true);
}
translate([-x_offset(w+w_pad),y_offset(w+w_pad,l+l_pad),0]){
	rotate([0,0,30]) cube([edge_length(w+w_pad),edge_length(w+w_pad),h_lid], center=true);
}}

// The cutout
translate([0,25,0]){
union(){
  rotate([0,0,0]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
  rotate([0,0,60]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
  rotate([0,0,120]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
}
}

}}