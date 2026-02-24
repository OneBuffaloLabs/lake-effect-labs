# Slasher Spheres: Jason Voorhees Pokéball

<p align="center">
  <img src="images/jason-crack-pokeball-hero.png" alt="Jason Voorhees Pokéball Battle Worn" width="600">
</p>

A multi-part, support-free 3D model combining a classic Pokéball with Jason Voorhees' iconic battle-worn hockey mask. Designed entirely in OpenSCAD for high-precision assembly, featuring a **flattened base for stability**, flush-fitting inserts, and a heavy-duty rectangular internal alignment peg.

## 📂 Project Structure

- `jason_ball.scad` — The core parametric OpenSCAD model.
- `jason-ball-top.stl` — The white top hemisphere featuring recessed mask pockets.
- `jason-ball-bottom.stl` — The black bottom hemisphere with a **flattened base** to prevent rolling.
- `jason-ball-ring.stl` — The main silver equatorial band.
- `jason-ball-front-ring.stl` — The outer silver button housing.
- `jason-ball-button.stl` — The stepped center red button.
- `jason-ball-filler.stl` — The large rectangular internal alignment peg.
- `jason-ball-chips-black.stl` — The black eye and breathing hole inserts.
- `jason-ball-chips-red.stl` — The red chevron inserts.
- `jason-ball-chips-silver.stl` — The silver axe-notch crack insert.
- `images/`
  - `jason-ball-exploded.png` — Exploded assembly preview.
  - `jason-crack-ball-exploded.png` — Exploded view featuring the silver crack.
  - `jason-crack-pokeball-hero.png` — Battle-worn hero shot.
  - `jason-pokeball-hero.png` — Standard version hero shot.
- `README.md` — This file.

## 🛠 Print Instructions

This model is designed to be printed in separate color batches and assembled.

### Slicer Settings

- **Material:** PLA or PETG.
- **Layer Height:** 0.2mm
- **Seam Position:** **Back (REQUIRED).** Set Z-seam alignment to the back of the model to ensure a clean surface finish on all front-facing features and inserts.
- **Orientation / Supports:** **NO SUPPORTS REQUIRED.** Print shells and the center ring with their large flat cutouts facing the build plate. Print the filler peg lying flat for maximum sheer strength.
- **Wall Perimeters:** **3 to 4 walls.** Extra walls ensure the bottom of the pockets are solid plastic rather than fragile infill.
- **Infill:** 15% Gyroid for shells; **100% Infill for all Chips** (black, red, and silver) to prevent snapping during installation.
- **Elephant Foot Compensation:** 0.15mm. **CRITICAL!** If the first layer squishes, the high-tolerance chips will not seat properly.

---

## 🧩 Assembly & Fit Guide

This model utilizes a **full friction-fit assembly**. The goal of this design is to require **minimal glue**.

1. **High-Precision Friction Fit:** All mechanical parts and mask chips are engineered with a strict **0.05mm clearance** to ensure a tight, secure snap-fit.
2. **Installation Steps:**
   - **Step 1 (The Face):** Press the black, red, and silver chips into the top shell pockets. They are designed to stay secure through friction and sit **0.05mm** proud of the surface.
   - **Step 2 (The Core):** Insert the rectangular filler peg into the flattened bottom shell. Slide the center ring over the peg, then press the top shell down.
   - **Step 3 (The Button):** Press the red button into the silver front ring, then press that assembly into the front cutout of the sphere.

3. **Troubleshooting:**
   - **Too Loose?** If parts do not stay seated due to printer variance, a tiny drop of CA glue (Super Glue) can be used. However, the design is optimized to avoid this whenever possible.
   - **Too Tight?** If inserts are impossible to press in, check your printer for over-extrusion or slightly lower your outer wall flow rate (by **2-5%**). You may also lightly sand the rectangular filler peg.
   - **Slop or Wiggle?** Ensure your Z-seam is not creating blobs inside the pockets. Use a hobby knife to remove any "elephant foot" flare from the bottom of the chips.

---

## 🔧 Customization

To adjust the tightness for your specific printer, open `jason_ball.scad` and tweak the clearance variables:

- `mechanical_clearance = 0.05;` (Controls internal peg and button assembly)
- `chip_clearance = 0.05;` (Controls face detail pocket fit)

---

_Disclaimer: This is a fan-art project provided for personal use only. It is not affiliated with, authorized by, or endorsed by the Friday the 13th franchise, New Line Cinema, Pokémon, or Nintendo._
