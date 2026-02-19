// ==========================================
// SNAPFIT-BILLS: MULTI-PART LOGO
// ==========================================

/* [Dimensions] */
// Target width of the final logo in mm (including base border)
target_width = 150;
// Total thickness of the white base plate
base_thickness = 6.0;
// Depth of the recessed pockets
pocket_depth = 2.5;
// Thickness of color inserts (stuck out by 0.5mm)
insert_thickness = 3.0;

/* [Borders & Gaps] */
// Thickness of the white outline around the outside
border_thickness = 2.0;
// The white gap between the red streak and the blue body
inner_gap = 0.6;
// Internal gap closer (expands and shrinks the core to fuse weird holes)
base_fill_gap = 5.0;

/* [Tolerances] */
// Gap between insert and pocket walls for friction fit
clearance = 0.10;

/* [Internal] */
master_svg = "images/bills_master.svg";
$fn = 64;
epsilon = 0.01;

// ==========================================
// --- ALIGNMENT MATH ---
// The actual width of the Buffalo paths inside the SVG canvas is ~741.54
svg_path_width = 741.54;

// Subtract the border from both sides so the final base hits the target_width exactly
logo_target_width = target_width - (border_thickness * 2);

// Calculate exact scale factor
scale_factor = logo_target_width / svg_path_width;
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
        offset(delta = inner_gap, chamfer = true) red_path();
    }
}

// ==========================================
// ASSEMBLY MODULES
// ==========================================

// 1. The White Base (Tray)
module white_base() {
    difference() {
        // Step A: Main unified silhouette (with Morphological Close to fix holes)
        linear_extrude(base_thickness) {
            offset(r = border_thickness) {
                // This +5 then -5 delta effectively "melts" the shapes together,
                // filling in any thin gaps or holes before drawing the white border.
                offset(delta = -base_fill_gap) {
                    offset(delta = base_fill_gap) {
                        raw_blue_path();
                        red_path();
                    }
                }
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

// PREVIEW COLOR VIEW
color("white") white_base();
color("red") translate([0,0,base_thickness - pocket_depth + 0.1]) red_insert();
color("blue") translate([0,0,base_thickness - pocket_depth + 0.1]) blue_inserts();