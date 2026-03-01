/* GHOSTFACE (SCREAM) POKÉBALL */

// --- PARAMETRIC VARIABLES ---
part_to_render = "all"; // [all, top, bottom, ring, front_ring, button, filler, chips_black, debug_2d_right_eye, debug_2d_left_eye, debug_2d_nose]
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

// --- EYE TWEAKS & PLACEMENT ---
right_eye_svg_x = -7;   // Shift the Right 2D SVG left/right
right_eye_svg_y = 10;   // Shift the Right 2D SVG up/down
left_eye_svg_x = -7;    // Shift the Left 2D SVG left/right
left_eye_svg_y = 10;    // Shift the Left 2D SVG up/down

eye_scale = 0.20;       // Scale of both SVGs

eye_tilt = 45;          // Move up/down on the ball
eye_pan = 30;           // Spread from center
right_eye_rotation = 20; // Spin the right eye in place
left_eye_rotation = -20;  // Spin the left eye in place

eye_pocket_depth = 3.5;   // Depth of the hole cut into the white shell
eye_chip_thickness = 2.5; // Thickness of the printed chip

// --- NOSE TWEAKS & PLACEMENT ---
nose_svg_x = -4.5;         // Shift the Nose 2D SVG left/right
nose_svg_y = 4.5;         // Shift the Nose 2D SVG up/down
nose_scale = 0.20;      // Scale of the Nose SVG (May need to be smaller than the eyes!)
nose_tilt = 25;         // Move up/down on the ball (Lower number = further down the face)
nose_pan = 0;           // Keep at 0 to stay dead center!
nose_rotation = 0;      // Spin the nose in place

// 3. DEPTH & RECESS
nose_pocket_depth = 3.5;   // Matches the eyes
nose_chip_thickness = 2.5; // Matches the eyes

// --- TOLERANCES & CLEARANCES ---
mechanical_clearance = 0.05;
chip_clearance = 0.05;
button_clearance = 0.0;
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

if (part_to_render == "debug_2d_right_eye") {
  color("red") cube([100, 0.5, 0.1], center=true); 
  color("green") cube([0.5, 100, 0.1], center=true); 
  color("black") linear_extrude(1) get_right_eye_2d();
} else if (part_to_render == "debug_2d_left_eye") {
  color("red") cube([100, 0.5, 0.1], center=true); 
  color("green") cube([0.5, 100, 0.1], center=true); 
  color("black") linear_extrude(1) get_left_eye_2d();
} else if (part_to_render == "debug_2d_nose") {
  color("red") cube([100, 0.5, 0.1], center=true); 
  color("green") cube([0.5, 100, 0.1], center=true); 
  color("black") linear_extrude(1) get_nose_2d();
} else if (part_to_render == "chips_black") { 
  color("black") layout_chips_black(); 
} else if (part_to_render == "all") {
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
      color(c_black) draw_nose(is_pocket=false, hover=15);
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
      color(c_black) draw_nose(is_pocket=false, hover=0);
    }
  }
} else {
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

    // CUT THE POCKETS!
    draw_eyes(is_pocket=true);
    draw_nose(is_pocket=true);
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

module get_right_eye_2d(clearance = 0) {
  offset(delta = clearance)
    translate([right_eye_svg_x, right_eye_svg_y])
      scale([eye_scale, eye_scale]) 
        mirror([0, 1])
          import("images/right_eye.svg");
}

module get_left_eye_2d(clearance = 0) {
  offset(delta = clearance)
    translate([left_eye_svg_x, left_eye_svg_y])
      scale([eye_scale, eye_scale]) 
        mirror([0, 1])
          import("images/left_eye.svg");
}

module get_nose_2d(clearance = 0) {
  offset(delta = clearance)
    translate([nose_svg_x, nose_svg_y])
      scale([nose_scale, nose_scale]) 
        mirror([0, 1])
          import("images/nose.svg");
}

module draw_eyes(is_pocket = true, hover = 0) {
  clearance = is_pocket ? 0 : -chip_clearance;
  recess_depth = eye_pocket_depth - eye_chip_thickness;
  z_off = is_pocket ? -eps : recess_depth;
  h_val = is_pocket ? eye_pocket_depth + eps : eye_chip_thickness;

  // Draw Right Eye (+pan)
  place_outward(eye_tilt, eye_pan, hover)
    rotate([0, 0, right_eye_rotation])
      translate([0, 0, z_off])
        linear_extrude(height=h_val)
          get_right_eye_2d(clearance);

  // Draw Left Eye (-pan)
  place_outward(eye_tilt, -eye_pan, hover)
    rotate([0, 0, left_eye_rotation])
      translate([0, 0, z_off])
        linear_extrude(height=h_val)
          get_left_eye_2d(clearance);
}

module draw_nose(is_pocket = true, hover = 0) {
  clearance = is_pocket ? 0 : -chip_clearance;
  recess_depth = nose_pocket_depth - nose_chip_thickness;
  z_off = is_pocket ? -eps : recess_depth;
  h_val = is_pocket ? nose_pocket_depth + eps : nose_chip_thickness;

  place_outward(nose_tilt, nose_pan, hover)
    rotate([0, 0, nose_rotation])
      translate([0, -5, z_off])
        linear_extrude(height=h_val)
          get_nose_2d(clearance);
}

// --- PRINTABLE CHIP LAYOUTS ---

module layout_chips_black() {
  // Right Eye
  translate([15, 0, 0])
    linear_extrude(height=eye_chip_thickness)
      get_right_eye_2d(-chip_clearance);

  // Left Eye
  translate([-15, 0, 0])
    linear_extrude(height=eye_chip_thickness)
      get_left_eye_2d(-chip_clearance);

  // Nose
  translate([0, 20, 0])
    linear_extrude(height=nose_chip_thickness)
      get_nose_2d(-chip_clearance);
}