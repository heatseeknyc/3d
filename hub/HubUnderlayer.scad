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
h_lid = 1;
w = (65) * scaling;
l = (86 + 50 + point_height(w)) * scaling; // 86 = Pi, 50 = Dongle, ~20 for point height

// Values for wall thickness
w_pad = 3;
l_pad = 3;

W = w + w_pad;
L = l + l_pad;
btm = W*0.9;

// The lid
function hex_len(width) = 2 * (cos(30) * width);
hex_edge = edge_length(w/1.6);

rotate([0,0,0]){
  difference(){
    difference(){
      union(){
        cube([W, L, h_lid], center=true); // Center Cube
        translate([x_offset(W),y_offset(W,L),0]){
        	rotate([0,0,-30]) cube([edge_length(W),edge_length(W),h_lid], center=true);
        }
        translate([-x_offset(W),y_offset(W,L),0]){
        	rotate([0,0,30]) cube([edge_length(W),edge_length(W),h_lid], center=true);
        }
      }
      translate([x_offset(btm),-y_offset2(btm,L),0]){
      	rotate([0,0,-30]) cube([edge_length(btm),edge_length(btm),h_lid], center=true);
      }
      translate([-x_offset(btm),-y_offset2(btm,L),0]){
      	rotate([0,0,30]) cube([edge_length(btm),edge_length(btm),h_lid], center=true);
      }
    }

    // The cutout
    translate([0,55,0]){
      union(){
      	rotate([0,0,0]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
      	rotate([0,0,60]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
      	rotate([0,0,120]) cube([hex_len(hex_edge),hex_edge,h_lid], center=true);
      }
    }
  }
}