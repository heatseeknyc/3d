$fn = 100;

// Functions for calculating the half-hexagons
function edge_length(width) = (width/2) / cos(30); // CAH
function point_height(width) = (width/2) * tan(30); // TOA
function leg(width) = edge_length(width) * sqrt(1/2);
function x_offset(width) = (width/2) - (leg(width) * cos(15));
function y_offset(width, length) = (length/2) - (leg(width) * sin(15));

//function x_offset2(width) = (width/2) + (leg(width) * sin(15));
function y_offset2(width, length) = (length/2) + (leg(width) * cos(15)) - point_height(w) + 2; // +2 is arbitrary, should fix.

// Values for wall thickness
h_pad = -1;
w_pad = 5;
l_pad = 5;

// Core size variables
scaling = 1;
lip = 3;
h = (30 + lip) * scaling;
w = (65 + w_pad) * scaling;
l = (75 + 50 + l_pad + point_height(w)) * scaling; // 86 = Pi, 50 = Dongle, ~20 for point height

btm = w*0.9;


// The lid
h_lid = 3;
function hex_len(width) = 2 * (cos(30) * width);
hex_edge = edge_length(w/1.6);

translate([0,0,0]){
difference(){
difference(){
union(){
cube([w, l, h_lid], center=true); // Center Cube
translate([-w/2.2,0,-h_lid*1.5]){cube([2, 5, 8], center=true);} // The teeth
translate([w/2.2,0,-h_lid*1.5]){cube([2, 5, 8], center=true);}
translate([x_offset(w),y_offset(w,l),0]){
	rotate([0,0,-30]) cube([edge_length(w),edge_length(w),h_lid], center=true);
}
translate([-x_offset(w),y_offset(w,l),0]){
	rotate([0,0,30]) cube([edge_length(w),edge_length(w),h_lid], center=true);
}}
translate([x_offset(btm),-y_offset2(btm,l),0]){
	rotate([0,0,-30]) cube([edge_length(btm),edge_length(btm),h_lid-h_pad], center=true);
}
translate([-x_offset(btm),-y_offset2(btm,l),0]){
	rotate([0,0,30]) cube([edge_length(btm),edge_length(btm),h_lid-h_pad], center=true);
}}

// The cutout
translate([0,40,2]){
union(){
	rotate([0,0,0]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
	rotate([0,0,60]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
	rotate([0,0,120]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
}}}}