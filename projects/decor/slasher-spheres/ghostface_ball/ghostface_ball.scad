/* GHOSTFACE (SCREAM) POKÉBALL */

// --- PARAMETRIC VARIABLES ---
part_to_render = "all"; // [all, top, bottom, ring, front_ring, button, filler, chips_black]
exploded_view = false;
debug_transparent_chips = false;

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
button_clearance = 0.0;
pocket_depth = 2.5;
filler_xy_clearance = 0.1;
filler_z_clearance = 0.5;

// --- MANIFOLD GEOMETRY & RESOLUTION ---
eps = 0.01;
$fn = $preview ? 32 : 120;

// --- Colors ---
top_color = "white";
bottom_color = "black";
ring_color = "black";
front_ring_color = "black";
button_color = "red";
filler_color = "black";

// --- RENDER LOGIC ---

c_black = debug_transparent_chips ? [0, 0, 0, 0.5] : "black";

if (part_to_render == "chips_black") { color("black") layout_chips_black(); }

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
      color(c_black) draw_right_eye(is_pocket=false, hover=15);
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
      color(c_black) draw_right_eye(is_pocket=false, hover=0);
    }
  }
} else if (part_to_render != "chips_black") {
  // --- EXPORT MODE ---
  if (part_to_render == "top") color(top_color) top_mask();
  if (part_to_render == "bottom") color(bottom_color) bottom_shell();
  if (part_to_render == "ring") color(ring_color) center_ring();
  if (part_to_render == "front_ring") color(front_ring_color) front_ring();
  if (part_to_render == "button") color(button_color) center_button();
  if (part_to_render == "filler") color(filler_color) alignment_filler();
}

// --- MAIN MODULES ---

module top_mask() {
  difference() {
    sphere(r=ball_radius);

    // Massive block to strictly cut everything below Z=3, killing ghost lines
    translate([0, 0, -47])
      cube([150, 150, 100], center=true);

    cube([filler_width + filler_xy_clearance, filler_length + filler_xy_clearance, filler_height + filler_z_clearance], center=true);

    translate([0, -ball_radius + front_pocket_depth, 0])
      rotate([90, 0, 0])
        cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);

    // Cut the right eye pocket!
    draw_right_eye(is_pocket=true);
  }
}

module bottom_shell() {
  difference() {
    sphere(r=ball_radius);

    translate([0, 0, 47])
      cube([150, 150, 100], center=true);

    translate([0, 0, -87])
      cube([150, 150, 100], center=true);

    cube([filler_width + filler_xy_clearance, filler_length + filler_xy_clearance, filler_height + filler_z_clearance], center=true);

    translate([0, -ball_radius + front_pocket_depth, 0])
      rotate([90, 0, 0])
        cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);
  }
}

module center_ring() {
  difference() {
    cylinder(r=ball_radius - 0.5, h=ring_height, center=true);

    cube([filler_width + filler_xy_clearance, filler_length + filler_xy_clearance, ring_height + eps * 2], center=true);

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
        cylinder(r=front_ring_outer_r - button_clearance, h=front_ring_depth, center=true);
        cylinder(r=front_ring_inner_r + button_clearance, h=front_ring_depth + eps * 2, center=true);
      }
}

module center_button() {
  translate([0, -(ball_radius - (front_ring_depth / 2)), 0])
    rotate([90, 0, 0])
      union() {
        cylinder(r=front_ring_inner_r - button_clearance, h=front_ring_depth, center=true);
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

// Loads the optimized, perfectly centered right eye SVG
module get_right_eye_2d(clearance = 0) {
  offset(delta = clearance)
    scale([0.20, 0.20])
      mirror([0, 1]) // Fixes the upside-down SVG import
        import("images/right_eye.svg");
}

// Generates a chip with a curved top and a deep, flat bottom
module local_chip_geometry(clearance = 0, protrusion = 0, floor_z = -6) {
  intersection() {
    // 1. Extrude from a deep flat floor (-6mm) to well above the surface
    // INCREASED HEIGHT from 5 to 20 to guarantee the massive eye clears the sphere curve
    translate([0, 0, floor_z])
      linear_extrude(height=abs(floor_z) + 20)
        get_right_eye_2d(clearance);

    // 2. Cut the top face using the exact curvature of the Pokéball.
    translate([0, 0, -ball_radius])
      sphere(r=ball_radius + protrusion);
  }
}

module draw_right_eye(is_pocket = true, hover = 0) {
  clearance = is_pocket ? 0 : -chip_clearance;

  // We force the pocket to be 6mm deep so the edges of the large eye don't get chopped off!
  floor_z = -6;
  protrusion = is_pocket ? eps : 0.5;

  // INCREASED TILT to 40 so it clears the Z=3 equator cut!
  place_outward(20, 20, hover)
    rotate([0, 0, 0])
      local_chip_geometry(clearance, protrusion, floor_z);
}

// --- PRINTABLE CHIP LAYOUTS ---

module layout_chips_black() {
  // Move the flat bottom (which sits at Z = -6) up by 6mm so it prints perfectly flat on the bed!
  translate([0, 0, 6])
    local_chip_geometry(clearance = -chip_clearance, protrusion = 0.5, floor_z = -6);
}