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
mechanical_clearance = 0.2;
chip_clearance = 0.25;
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
      color(c_black) draw_ghostface_mask(is_pocket=false, hover=15);
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
      color(c_black) draw_ghostface_mask(is_pocket=false, hover=0);
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

    translate([0, 0, -47])
      cube([150, 150, 100], center=true);

    cube([filler_width + mechanical_clearance, filler_length + mechanical_clearance, filler_height + mechanical_clearance], center=true);

    translate([0, -ball_radius + front_pocket_depth, 0])
      rotate([90, 0, 0])
        cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);

    draw_ghostface_mask(is_pocket=true);
  }
}

module bottom_shell() {
  // Note: For the "dripping" effect from your reference image, paint/post-processing 
  // is recommended rather than geometry cuts to maintain the ring hardware structure!
  difference() {
    sphere(r=ball_radius);

    translate([0, 0, 47])
      cube([150, 150, 100], center=true);

    cube([filler_width + mechanical_clearance, filler_length + mechanical_clearance, filler_height + mechanical_clearance], center=true);

    translate([0, -ball_radius + front_pocket_depth, 0])
      rotate([90, 0, 0])
        cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);
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
      difference() {
        union() {
          cylinder(r=front_ring_inner_r - mechanical_clearance, h=front_ring_depth, center=true);
          translate([0, 0, front_ring_depth / 2])
            cylinder(r=button_inner_radius, h=2, center=false);
        }

        // Tiny Ghostface Cutout on the red button!
        translate([0, 0, front_ring_depth / 2 + 1])
          linear_extrude(height=5)
            import_ghostface_svg(0, 0.007);
        // Super tiny scale
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

// Standardized SVG importer that centers and flips coordinates
module import_ghostface_svg(clearance, scale_factor) {
  offset(delta=-clearance)
    scale([scale_factor, scale_factor, 1])
      translate([-361.17, -566.11, 0])
        mirror([0, 1, 0]) // Flip Y to match OpenSCAD coordinates
          import("images/ghostface.svg");
}

module draw_ghostface_mask(is_pocket = true, hover = 0) {
  clearance = is_pocket ? 0 : chip_clearance;
  z_off = is_pocket ? -eps : -0.05;
  h_val = is_pocket ? pocket_depth + 10 : pocket_depth + 10;

  intersection() {
    place_outward(35, 0, hover)
      translate([0, 0, z_off])
        linear_extrude(height=h_val)
          import_ghostface_svg(clearance, 0.048);

    // If it's a chip, give it the curved outer roof of the Pokéball
    if (!is_pocket) {
      sphere(r=ball_radius + 0.05);
    }
  }
}

// --- PRINTABLE CHIP LAYOUTS ---

module layout_chips_black() {
  // We extrude the flat SVG on the print bed, but intersect it with a
  // sphere hovering just above it to create a perfectly curved roof!
  intersection() {
    linear_extrude(height=pocket_depth + 10)
      import_ghostface_svg(chip_clearance, 0.048);

    translate([0, 0, pocket_depth - ball_radius])
      sphere(r=ball_radius + 0.05);
  }
}
