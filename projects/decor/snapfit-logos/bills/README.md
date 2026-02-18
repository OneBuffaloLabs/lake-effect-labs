# SnapFit Logo: Buffalo Bills

<p align="center">
  <img src="images/snapfit-bills-hero.png" alt="Buffalo Bills SnapFit Logo" width="600">
</p>

A multi-part, glue-less friction-fit 3D model of the Buffalo Bills logo. Designed in OpenSCAD for high-precision tolerances.

## 📂 Project Structure

- `snapfit_bills.scad` — The core parametric OpenSCAD model.
- `snapfit-bills-base-white.stl` — The main backing plate with recessed pockets.
- `snapfit-bills-insert-blue.stl` — The main buffalo body and legs.
- `snapfit-bills-insert-red.stl` — The red streak insert.
- `images/`
  - `bills_master.svg` — The source vector file with defined path IDs.
  - `snapfit-bills-hero.png` — High-resolution preview image.
- `README.md` — This file.

## 🛠 Print Instructions

This model is designed to be printed in three separate color stages and snapped together.

### Slicer Settings

- **Material:** PLA (recommended for stiffness).
- **Layer Height:** 0.2mm.
- **Wall Generator:** Use **Arachne** (standard in OrcaSlicer / Bambu Studio / Cura 5+). This ensures the thin white gaps around the nose print accurately.
- **Elephant Foot Compensation:** 0.15mm to 0.2mm. _CRITICAL for the snap fit! If the first layer squishes out, the pieces will not fit into the base._
- **Top Surface Pattern:** Concentric (provides a professional, sweeping finish that follows the logo's curves).
- **Infill:** 15% (Grid or Gyroid).

## 🧩 Assembly & Fit Guide

This model is a **SnapFit** design, meaning it relies on friction and precise tolerances to hold together.

1. **Clearance Check:** The model is designed with a standard `0.15mm` clearance. If your printer's flow rate is perfectly calibrated, the pieces will "click" in firmly.
2. **Installation:** Lay the white base on a flat, hard surface. Position the blue body first, then the red streak. Press down firmly with your thumb.
3. **Troubleshooting:**
   - **Too Tight?** If you cannot press the pieces in, double-check your slicer's _Elephant Foot Compensation_. You can also lightly scrape/sand the bottom edges of the inserts.
   - **Too Loose?** If the pieces fall out when held up, a single tiny drop of CA glue (Super Glue) in the pocket will secure them permanently.

## 🔧 Customization

To structurally adjust the tightness of the fit without using glue, open `snapfit_bills.scad` and tweak the `clearance` variable:

- `clearance = 0.15;` (Standard Tight)
- `clearance = 0.20;` (Easier assembly/Looser)
- `clearance = 0.10;` (Extremely tight)
