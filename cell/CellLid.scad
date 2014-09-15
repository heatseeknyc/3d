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
h_lid = 1;

// Values for interior space
w_pad = 3;
l_pad = 3;

// The teeth
t_height = 6;

rotate([180,00,0]){
difference(){
union(){
cube([w+w_pad, l+l_pad, h_lid], center=true); // Center Cube
translate([-(w+w_pad)/2.15,0,-t_height/2]){cube([1.5, 5, t_height], center=true);} // The teeth
translate([(w+w_pad)/2.15,0,-t_height/2]){cube([1.5, 5, t_height], center=true);}
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
}}