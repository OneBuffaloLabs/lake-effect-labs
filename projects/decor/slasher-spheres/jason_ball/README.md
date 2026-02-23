# Slasher Spheres: Jason Voorhees Pokéball

<p align="center">
  <img src="images/jason-pokeball-hero.png" alt="Jason Voorhees Pokéball" width="600">
</p>

A multi-part, support-free 3D model combining a classic Pokéball with Jason Voorhees' iconic hockey mask. Designed entirely in OpenSCAD for high-precision assembly, featuring flush-fitting inserts and a heavy-duty rectangular internal alignment peg. 

## 📂 Project Structure

- `jason_pokeball.scad` — The core parametric OpenSCAD model.
- `jason-top-shell-white.stl` — The top hemisphere featuring the recessed mask pockets.
- `jason-bottom-shell-black.stl` — The solid bottom hemisphere.
- `jason-center-ring-black.stl` — The main equatorial band with the front button cutout.
- `jason-front-ring-silver.stl` — The outer silver button housing.
- `jason-button-red.stl` — The stepped center red button.
- `jason-filler-peg.stl` — The large rectangular internal alignment peg.
- `jason-chips-black.stl` — The black eye and breathing hole inserts.
- `jason-chips-red.stl` — The red chevron inserts.
- `images/`
  - `jason-pokeball-hero.png` — High-resolution preview image.
- `README.md` — This file.

## 🛠 Print Instructions

This model is designed to be printed in separate color batches and assembled. 

### Slicer Settings

- **Material:** PLA or PETG.
- **Layer Height:** 0.2mm
- **Orientation / Supports:** **NO SUPPORTS REQUIRED.** Print the `top_shell`, `bottom_shell`, and `center_ring` with their large flat cutouts facing flat on the build plate. Print the `filler_peg` lying flat on its back for maximum sheer strength.
- **Wall Perimeters:** **3 to 4 walls.** Since the mask pockets cut 2.5mm into the 4mm thick top shell, extra walls ensure the bottom of the pockets are solid plastic rather than fragile infill.
- **Infill:** 15% Gyroid for the shells and ring. **100% Infill for the Chips** (the black and red inserts are only 2.5mm thick, so printing them solid prevents snapping).
- **Elephant Foot Compensation:** 0.15mm. *CRITICAL! If the first layer of your black and red chips squish outward, they will not fit into the precision pockets on the white shell.*

## 🧩 Assembly & Fit Guide

This model uses a hybrid assembly approach. The core structural parts use a tight friction fit via the internal rectangular peg, while the mask chips are designed to drop in with a tiny gap for adhesive.

1. **Dual-Tolerance Design:** - **Mechanical Parts (0.20mm clearance):** The filler peg, center ring, front ring, and button are dimensioned for a snug slip-fit.
   - **Mask Chips (0.25mm clearance):** The eyes, holes, and chevrons have slightly more clearance so they drop into the white shell effortlessly.
2. **Installation:** - **Step 1 (The Face):** Place a tiny drop of CA glue (Super Glue) into the pockets of the white top shell and press the black and red chips into place. They are dimensioned to sit perfectly flush with the curved surface.
   - **Step 2 (The Core):** Insert the rectangular filler peg into the bottom shell. Slide the center ring over the peg, then press the top shell down onto the remaining exposed peg. 
   - **Step 3 (The Button):** Slide the red button into the silver front ring, then slide that assembly directly into the front cutout of the sphere.
3. **Troubleshooting:**
   - **Too Tight?** If the internal peg won't fit into the shells, check your printer for over-extrusion, or lightly sand the sides of the rectangular peg.
   - **Chips won't go in?** Make sure you applied Elephant Foot Compensation in your slicer. You can scrape the bottom edges of the chips with a hobby knife to remove first-layer squish.

## 🔧 Customization

To structurally adjust the tightness of the fits, open `jason_pokeball.scad` in OpenSCAD and tweak the clearance variables at the very top of the file:

- `mechanical_clearance = 0.2;` (Adjusts the tightness of the internal peg and button assembly)
- `chip_clearance = 0.25;` (Adjusts how tightly the face details fit into their pockets)

---

*Disclaimer: This is a fan-art project provided for personal use only. It is not affiliated with, authorized by, or endorsed by the Friday the 13th franchise, New Line Cinema, Pokémon, or Nintendo.*