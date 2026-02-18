// ==========================================
// SNAPFIT-BILLS: MULTI-PART LOGO (SVG ID VERSION)
// ==========================================

/* [Dimensions] */
// Target width of the final logo in mm
target_width = 150;
// Total thickness of the white base plate
base_thickness = 3.0;
// Depth of the recessed pockets
pocket_depth = 2.0;
// Thickness of color inserts (stuck out by 0.5mm)
insert_thickness = 2.5;

/* [Borders & Gaps] */
// Thickness of the white outline around the outside
border_thickness = 2.0;
// The white gap between the red streak and the blue body
inner_gap = 0.6;

/* [Tolerances] */
// Gap between insert and pocket walls for friction fit
clearance = 0.15;

/* [Internal] */
master_svg = "images/bills_master.svg";
$fn = 64;
epsilon = 0.01;

// ==========================================
// --- ALIGNMENT MATH ---
// The original SVG width from the Inkscape viewBox
svg_original_width = 2102.667;
// Calculate exact scale factor to hit target_width without losing alignment
scale_factor = target_width / svg_original_width;
// ==========================================

// ==========================================
// CORE COLOR MODULES
// ==========================================

module red_path() {
    scale([scale_factor, scale_factor])
        import(file=master_svg, id="path_red");
}

module raw_blue_path() {
    scale([scale_factor, scale_factor])
        import(file=master_svg, id="path_blue");
}

module true_blue_path() {
    difference() {
        raw_blue_path();
        // 'delta' and 'chamfer=true' expand the streak without creating a destructive spike
        offset(delta = inner_gap, chamfer = true) red_path();
    }
}

// ==========================================
// ASSEMBLY MODULES
// ==========================================

// 1. The White Base (Tray)
module white_base() {
    difference() {
        // Step A: Main unified silhouette
        linear_extrude(base_thickness) {
            offset(r = border_thickness) {
                raw_blue_path();
                red_path();
            }
        }

        // Step B: Cut the Red Pocket
        translate([0, 0, base_thickness - pocket_depth])
            linear_extrude(pocket_depth + epsilon)
                offset(delta = clearance, chamfer=true) red_path();

        // Step C: Cut the Blue Pockets
        translate([0, 0, base_thickness - pocket_depth])
            linear_extrude(pocket_depth + epsilon)
                offset(delta = clearance, chamfer=true) true_blue_path();
    }
}

// 2. The Color Inserts
module red_insert() {
    linear_extrude(insert_thickness) red_path();
}

module blue_inserts() {
    linear_extrude(insert_thickness) true_blue_path();
}

// ==========================================
// RENDER SELECTION
// Un-comment one line at a time to export to STL
// ==========================================

// white_base();
// red_insert();
// blue_inserts();

// PREVIEW COLOR VIEW (Un-comment to see final look)
color("white") white_base();
color("red") translate([0,0,base_thickness - pocket_depth + 0.1]) red_insert();
color("blue") translate([0,0,base_thickness - pocket_depth + 0.1]) blue_inserts();