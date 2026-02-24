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

// --- GHOSTFACE LOGO SCALE ---
mask_scale = 0.06; // Scaled to ~43x68mm. Perfect size for the top dome.

// --- MANIFOLD GEOMETRY & RESOLUTION ---
eps = 0.01;
$fn = 120; // High res for smooth curves

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
      color(c_black) draw_ghostface_chip(hover=15);
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
      color(c_black) draw_ghostface_chip(hover=0);
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

    // Subtract the curved pocket!
    pocket_volume(hover = 0);
  }
}

module bottom_shell() {
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
          rotate([0, 0, 180]) // Upright orientation
            linear_extrude(height=5)
              import_ghostface_svg(0, 0.007);
      }
}

// --- CURVED PROJECTION ENGINE ---

// Standardized SVG importer.
// Uses positive expansion for pockets to avoid breaking the 2D polygon.
module import_ghostface_svg(expand, scale_factor) {
  if (expand > 0) {
    offset(delta=expand, chamfer=true)
      scale([scale_factor, scale_factor])
        mirror([0, 1]) // Flips Y AFTER it is centered
          translate([-361.17, -566.11]) // Center perfectly on the origin
            import("images/ghostface.svg");
  } else {
    scale([scale_factor, scale_factor])
      mirror([0, 1])
        translate([-361.17, -566.11])
          import("images/ghostface.svg");
  }
}

// Generates a deep 3D cylinder/cone from the mask shape
module mask_cutter(expand) {
  rotate([90, 0, 0])
    translate([0, 0, -10]) // Starts slightly behind the core
      linear_extrude(height=ball_radius + 20) // Pierces completely through the front
        import_ghostface_svg(expand, mask_scale);
}

// Intersects the cutter with a spherical shell to create a curved pocket volume
module pocket_volume(hover = 0) {
  rotate([0, 0, 0]) // Pan
    rotate([-35, 0, 0]) // Tilt 35 degrees up
      intersection() {
        mask_cutter(chip_clearance); // Pocket gets the mechanical clearance!
        difference() {
          sphere(r = ball_radius + hover + eps);
          sphere(r = ball_radius + hover - pocket_depth);
        }
      }
}

// Intersects the cutter with a shell to create the positive physical chip
module draw_ghostface_chip(hover = 0) {
  rotate([0, 0, 0]) // Pan
    rotate([-35, 0, 0]) // Tilt 35 degrees up
      intersection() {
        mask_cutter(0); // Chip is true-to-size
        difference() {
          sphere(r = ball_radius + hover);
          sphere(r = ball_radius + hover - pocket_depth);
        }
      }
}

// --- PRINTABLE CHIP LAYOUTS ---

module layout_chips_black() {
  // To print a curved shell, we orient the outer face pointing straight up (+Z)
  // and drop the lowest inner point exactly onto the print bed (Z=0).
  translate([0, 0, -(ball_radius - pocket_depth)])
    rotate([-90, 0, 0]) // Points the face UP
      intersection() {
        mask_cutter(0);
        difference() {
          sphere(r = ball_radius);
          sphere(r = ball_radius - pocket_depth);
        }
      }
}