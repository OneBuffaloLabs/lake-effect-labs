// ==========================================
// CREALITY K2 SE TOOL KIT HOLDER (V6)
// ==========================================

/* [Mounting Specifications] */
hole_spacing = 110.63; 
screw_diameter = 4.5;  

/* [Main Body Dimensions] */
width = 140;           
depth = 68;            // Deepened to fit 3 distinct rows of tools
thickness = 4.0;       
backplate_height = 30; 

$fn = 64;
epsilon = 0.01;

module tool_holder() {
    difference() {
        // ======================================
        // ADDITIVE SHAPES (The Solid Body)
        // ======================================
        union() {
            // Backplate
            cube([width, thickness, backplate_height]);
            
            // Main Shelf
            cube([width, depth, thickness]);
            
            // Glue Stick Cup
            translate([46, 38, -25]) 
                cylinder(h=25, d=29); 

            // Mechanical Grease Cup
            translate([78, 38, -20]) 
                cylinder(h=20, d=23.5); 
                
            // Front Accessory Hook (Right side - 8mm thick, 13mm gap)
            translate([132, depth, 0]) 
                cube([8, 17, thickness]); 
            translate([132, depth + 17 - thickness, 0]) 
                cube([8, thickness, 10]); 
        }

        // ======================================
        // SUBTRACTIVE SHAPES (Holes & Slots)
        // ======================================
        
        // MOUNTING HOLES (M4)
        translate([(width/2) - (hole_spacing/2), -epsilon, backplate_height/2])
            rotate([-90, 0, 0]) 
                cylinder(h=thickness + 2, d=screw_diameter);
                
        translate([(width/2) + (hole_spacing/2), -epsilon, backplate_height/2])
            rotate([-90, 0, 0]) 
                cylinder(h=thickness + 2, d=screw_diameter);

        // --- ROW 1: BACK ---

        // Flush Cutters
        translate([50, 12, -epsilon]) cube([25, 12, thickness + 2]);

        // Scraper Slot
        translate([90, 12, -epsilon]) cube([42, 6, thickness + 2]);

        // --- ROW 2: MIDDLE ---
        
        // Wrench Slide-In Slot
        translate([16, 35, -epsilon]) cylinder(h=thickness + 2, d=15);
        translate([8.5, 35, -epsilon]) cube([15, 35, thickness + 2]);

        // Glue Stick Inner Hole (Stops 2mm before the bottom of the cup)
        translate([46, 38, -23]) cylinder(h=30, d=24);

        // Grease Tube Inner Hole (Stops 2mm before the bottom of the cup)
        translate([78, 38, -18]) cylinder(h=30, d=18.5);

        // Nozzle Brush Hole (11.5mm tool -> 13mm hole)
        translate([100, 38, -epsilon]) cylinder(h=thickness + 2, d=13);

        // Flash Drive Slot (14x7mm to fit the 12mm metal part, plastic rests on top)
        translate([118, 35, -epsilon]) cube([14, 7, thickness + 2]);

        // --- ROW 3: FRONT EDGE ---
        
        // L-Shaped Socket Wrench (11mm tool -> 12.5mm hole)
        translate([42, 60, -epsilon]) cylinder(h=thickness + 2, d=12.5);

        // Small Screwdriver (2.6mm tool -> 3.5mm hole)
        translate([58, 60, -epsilon]) cylinder(h=thickness + 2, d=3.5);

        // Allen 1 (1.6mm tool -> 2.5mm hole)
        translate([68, 60, -epsilon]) cylinder(h=thickness + 2, d=2.5);

        // Allen 2 (2.5mm tool -> 3.5mm hole)
        translate([78, 60, -epsilon]) cylinder(h=thickness + 2, d=3.5);

        // Allen 3 (3.0mm tool -> 4.5mm hole)
        translate([88, 60, -epsilon]) cylinder(h=thickness + 2, d=4.5);

        // Nozzle Cleaning Tool (1.2mm tool -> 2.5mm hole to catch the loop)
        translate([98, 60, -epsilon]) cylinder(h=thickness + 2, d=2.5);
    }
}

// Render the part
tool_holder();