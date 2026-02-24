/* JASON VOORHEES POKÉBALL */

// --- PARAMETRIC VARIABLES ---
part_to_render = "all"; // [all, top, bottom, ring, front_ring, button, filler, chips_black, chips_red, chips_silver]
exploded_view = false;
debug_transparent_chips = false; // TRUE = Glass chips so you can see the holes!

ball_radius = 40;
ring_height = 6;

// Rectangular Filler Dimensions
filler_width = 24;
filler_length = 14;
filler_height = 18;

// Front Assembly Dimensions
front_ring_outer_r = 13;
front_ring_inner_r = 9;
front_ring_depth = 4;
button_inner_radius = 7;
front_pocket_depth = 6;

// --- TOLERANCES & CLEARANCES ---
mechanical_clearance = 0.05;
chip_clearance = 0.05;
pocket_depth = 2.5;

// --- MANIFOLD GEOMETRY & RESOLUTION ---
eps = 0.01;
$fn = 64;

// --- Colors ---
top_color = "white";
bottom_color = "black";
ring_color = "silver";
front_ring_color = "silver";
button_color = "red";
filler_color = "black";
crack_color = "silver";

// --- RENDER LOGIC ---

// Helper colors for the transparent debugger!
c_black = debug_transparent_chips ? [0, 0, 0, 0.5] : "black";
c_red = debug_transparent_chips ? [1, 0, 0, 0.5] : "red";
c_silver = debug_transparent_chips ? [0.75, 0.75, 0.75, 0.5] : crack_color;

if (part_to_render == "chips_black") { color("black") layout_chips_black(); }
if (part_to_render == "chips_red") { color("red") layout_chips_red(); }
if (part_to_render == "chips_silver") { color(crack_color) layout_chips_silver(); }

if (part_to_render == "all") {
  if (exploded_view == true) {
    // --- EXPANDED VIEW ---
    translate([0, 0, 35]) color(top_color) top_mask();
    translate([0, 0, -35]) color(bottom_color) bottom_shell();
    color(ring_color) center_ring();
    translate([0, -20, 0]) color(front_ring_color) front_ring();
    translate([0, -30, 0]) color(button_color) center_button();
    translate([0, 0, 15]) color(filler_color) alignment_filler();

    translate([0, 0, 35]) {
      color(c_black) draw_eyes(is_pocket=false, hover=15);
      color(c_black) draw_top_holes(is_pocket=false, hover=15);
      color(c_red) draw_top_chevrons(is_pocket=false, hover=15);
      color(c_silver) draw_top_crack(is_pocket=false, hover=15);
    }
    translate([0, 0, -35]) {
      color(c_red) draw_bottom_chevrons(is_pocket=false, hover=15);
    }
  } else {
    // --- NORMAL ASSEMBLED VIEW ---
    translate([0, 0, 0.02]) color(top_color) top_mask();
    translate([0, 0, -0.02]) color(bottom_color) bottom_shell();
    color(ring_color) center_ring();
    color(front_ring_color) front_ring();
    color(button_color) center_button();
    color(filler_color) alignment_filler();

    translate([0, 0, 0.02]) {
      color(c_black) draw_eyes(is_pocket=false, hover=0);
      color(c_black) draw_top_holes(is_pocket=false, hover=0);
      color(c_red) draw_top_chevrons(is_pocket=false, hover=0);
      color(c_silver) draw_top_crack(is_pocket=false, hover=0);
    }
    translate([0, 0, -0.02]) {
      color(c_red) draw_bottom_chevrons(is_pocket=false, hover=0);
    }
  }
} else if (part_to_render != "chips_black" && part_to_render != "chips_red" && part_to_render != "chips_silver") {
  // --- EXPORT MODE ---
  if (part_to_render == "top") color("white") top_mask();
  if (part_to_render == "bottom") color("black") bottom_shell();
  if (part_to_render == "ring") color("#2a2a2a") center_ring();
  if (part_to_render == "front_ring") color("silver") front_ring();
  if (part_to_render == "button") color("red") center_button();
  if (part_to_render == "filler") color("gold") alignment_filler();
}

// --- MAIN MODULES ---

module top_mask() {
  difference() {
    sphere(r=ball_radius);

    // Massive block to strictly cut everything below Z=3, killing ghost lines
    translate([0, 0, -47])
      cube([150, 150, 100], center=true);

    cube([filler_width + mechanical_clearance, filler_length + mechanical_clearance, filler_height + mechanical_clearance], center=true);

    translate([0, -ball_radius + front_pocket_depth, 0])
      rotate([90, 0, 0])
        cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);

    draw_eyes(is_pocket=true);
    draw_top_chevrons(is_pocket=true);
    draw_top_holes(is_pocket=true);
    draw_top_crack(is_pocket=true);
  }
}

module bottom_shell() {
  difference() {
    sphere(r=ball_radius);

    // Massive block to strictly cut everything above Z=-3, killing ghost lines
    translate([0, 0, 47])
      cube([150, 150, 100], center=true);

    // Massive block to cut a 3mm flat resting plane on the bottom of the ball
    translate([0, 0, -87])
      cube([150, 150, 100], center=true);

    cube([filler_width + mechanical_clearance, filler_length + mechanical_clearance, filler_height + mechanical_clearance], center=true);

    translate([0, -ball_radius + front_pocket_depth, 0])
      rotate([90, 0, 0])
        cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);

    draw_bottom_chevrons(is_pocket=true);
  }
}

module center_ring() {
  difference() {
    cylinder(r=ball_radius - 0.5, h=ring_height, center=true);

    cube([filler_width + mechanical_clearance, filler_length + mechanical_clearance, ring_height + eps * 2], center=true);

    translate([0, -ball_radius + front_pocket_depth, 0])
      rotate([90, 0, 0])
        cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);
  }
}

module alignment_filler() {
  cube([filler_width, filler_length, filler_height], center=true);
}

module front_ring() {
  translate([0, -(ball_radius - (front_ring_depth / 2)), 0])
    rotate([90, 0, 0])
      difference() {
        cylinder(r=front_ring_outer_r - mechanical_clearance, h=front_ring_depth, center=true);
        cylinder(r=front_ring_inner_r + mechanical_clearance, h=front_ring_depth + eps * 2, center=true);
      }
}

module center_button() {
  translate([0, -(ball_radius - (front_ring_depth / 2)), 0])
    rotate([90, 0, 0])
      union() {
        cylinder(r=front_ring_inner_r - mechanical_clearance, h=front_ring_depth, center=true);
        translate([0, 0, front_ring_depth / 2])
          cylinder(r=button_inner_radius, h=2, center=false);
      }
}

// --- FEATURE PLACEMENT ENGINE ---

module place_outward(tilt, pan, hover = 0) {
  rotate([0, 0, pan])
    rotate([-tilt, 0, 0])
      translate([0, -(ball_radius + hover), 0])
        rotate([-90, 0, 0])
          children();
}

module draw_eyes(is_pocket = true, hover = 0) {
  r_val = is_pocket ? 6 : 6 - chip_clearance;
  z_off = is_pocket ? -eps : -0.05;
  h_val = is_pocket ? pocket_depth + eps : pocket_depth;

  for (m = [1, -1]) {
    place_outward(25, m * 28, hover)
      rotate([0, 0, m * 10])
        translate([0, 0, z_off])
          scale([1.3, 1, 1])
            cylinder(r=r_val, h=h_val);
  }
}

module draw_top_chevrons(is_pocket = true, hover = 0) {
  r_big = is_pocket ? 7.5 : 7.5 - chip_clearance;
  z_off = is_pocket ? -eps : -0.05;
  h_val = is_pocket ? pocket_depth + eps : pocket_depth;

  place_outward(37, 0, hover)
    rotate([0, 0, 90])
      translate([0, 0, z_off])
        scale([.8, 2, 1])
          cylinder(r=r_big, h=h_val, $fn=3);
}

module draw_bottom_chevrons(is_pocket = true, hover = 0) {
  r_small = is_pocket ? 5.5 : 5.5 - chip_clearance;
  z_off = is_pocket ? -eps : -0.05;
  h_val = is_pocket ? pocket_depth + eps : pocket_depth;

  place_outward(-25, 42, hover)
    rotate([0, 0, 225])
      translate([0, 0, z_off])
        scale([2, .5, 1])
          cylinder(r=r_small, h=h_val, $fn=3);

  place_outward(-25, -42, hover)
    rotate([0, 0, -45])
      translate([0, 0, z_off])
        scale([2, .5, 1])
          cylinder(r=r_small, h=h_val, $fn=3);
}

module draw_top_holes(is_pocket = true, hover = 0) {
  r_val = is_pocket ? 2.5 : 2.5 - chip_clearance;
  z_off = is_pocket ? -eps : -0.05;
  h_val = is_pocket ? pocket_depth + eps : pocket_depth;

  module h(tilt, pan) {
    place_outward(tilt, pan, hover) translate([0, 0, z_off]) cylinder(r=r_val, h=h_val);
  }

  // --- 'U' Holes ---
  // --- Top Row ---
  h(70, 34);
  h(70, -34);

  // --- Middle Row ---
  h(60, 27);
  h(60, -27);

  // --- Bottom Row ---
  h(48, 22.5);
  h(48, 7.5);
  h(48, -7.5);
  h(48, -22.5);

  // --- Left Cheek Holes ---
  h(20, -60);
  h(15, -70);
  h(25, -70);

  // --- Right Cheek Holes ---
  h(20, 60);
  h(15, 70);
  h(25, 70);
}

module draw_top_crack(is_pocket = true, hover = 0) {
  clearance = is_pocket ? 0 : chip_clearance;
  z_off = is_pocket ? -eps : -0.05;
  h_val = is_pocket ? pocket_depth + eps : pocket_depth;

  place_outward(45, -70, hover)
    rotate([0, 0, 100])
      translate([0, 0, z_off])
        linear_extrude(height=h_val)
          offset(delta=-clearance)
            polygon(
              points=[
                [-5, 12],
                [-2, 4],
                [-4, -2],
                [-1, -12],
                [2, -12],
                [-1, -2],
                [1, 4],
                [-2, 12],
              ]
            );
}

// --- PRINTABLE CHIP LAYOUTS ---

module layout_chips_black() {
  translate([-15, -15, 0]) rotate([0, 0, 25]) scale([1.3, 1, 1]) cylinder(r=6 - chip_clearance, h=pocket_depth);
  translate([15, -15, 0]) rotate([0, 0, -25]) scale([1.3, 1, 1]) cylinder(r=6 - chip_clearance, h=pocket_depth);

  for (i = [0:13]) {
    translate([-20 + (i % 7) * 8, 10 + floor(i / 7) * 12, 0])
      cylinder(r=2.5 - chip_clearance, h=pocket_depth);
  }
}

module layout_chips_red() {
  translate([0, 15, 0]) scale([.8, 2, 1]) cylinder(r=7.5 - chip_clearance, h=pocket_depth, $fn=3);
  translate([-12, -5, 0]) scale([2, .5, 1]) cylinder(r=5.5 - chip_clearance, h=pocket_depth, $fn=3);
  translate([12, -5, 0]) scale([2, .5, 1]) cylinder(r=5.5 - chip_clearance, h=pocket_depth, $fn=3);
}

module layout_chips_silver() {
  translate([30, -15, 0])
    linear_extrude(height=pocket_depth)
      offset(delta=-chip_clearance)
        polygon(
          points=[
            [-5, 12],
            [-2, 4],
            [-4, -2],
            [-1, -12],
            [2, -12],
            [-1, -2],
            [1, 4],
            [-2, 12],
          ]
        );
}