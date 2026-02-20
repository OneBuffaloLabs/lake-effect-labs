# K2 SE Tool Kit Holder (Official Enclosure Edition)

<p align="center">
<img src="images/k2-se-tool-holder-hero.png" alt="K2 SE Tool Kit Holder" width="600">
</p>

A high-precision, side-mounted organizer designed specifically for the **Official Creality K2 SE/K1 SE Enclosure**. This holder utilizes the existing 3.4mm mounting points on the transparent PC panels to keep your entire maintenance kit organized and upright.

## 📂 Project Structure

* `k2-se-tool-holder.scad` — The core parametric OpenSCAD model.
* `k2-se-tool-holder.stl` — The exported print-ready file.
* `k2-se-tool-holder.3mf` — Multi-plate project file with optimized slicer settings.
* `images/` — Screenshots and photos of the installation.
* `README.md` — This file.

## 🛠 Required Hardware & Compatibility

**🚨 IMPORTANT:** The stock K2 SE is an open-frame printer. This mod **requires** the official enclosure:

* **Required Enclosure:** [Creality Official K2 SE/K1 SE Transparent PC Enclosure](https://www.amazon.com/Creality-Transparent-Temperature-Protective-Customized/dp/B0FSQFJHZ1)
* **Mounting Spacing:** **104.96 mm** (center-to-center).
* **Hardware:** * 2x **M3-0.5 x 12mm** Bolts (Flat Head Phillips or Hex).
* 2x **M3 Hex Nuts**.
* 2x **M3 Flat Washers** (Highly recommended to protect the transparent PC panels).

## 🛠 Print Instructions

### Slicer Settings

* **Orientation:** Print with the **Backplate flat on the build plate**.
* **Material:** PLA or PETG.
* **Wall Loops:** **4 loops**. Solid walls around the mounting holes and tool slots are critical for durability.
* **Wall Generator:** **Arachne** is mandatory to maintain the 0.2mm precision tolerances for the Allen key and nozzle cleaner holes.
* **Infill:** 25% Gyroid.
* **Supports:** **REQUIRED**. Use **Tree (Auto)** supports. They should only generate under the hanging cups and the front hook.

## 🔧 Tool Compatibility

This holder uses ultra-tight tolerances to prevent "L-shaped" tools from tilting or falling out:

* **Glue Stick (25mm) & Mechanical Grease (19mm):** Custom-sized drop-in cups.
* **Wrench:** Slide-in front slot with a 4mm neck groove for a flush fit.
* **Scraper:** Dedicated 42mm x 3mm rear slot.
* **Flush Cutters:** 34mm wide center-back slot.
* **Front Edge Tools:** Grouped for easy access. Includes L-Shaped Socket Wrench (11.2mm), Small Screwdriver, 4x Allen Keys (1.6mm, 2.2mm, 2.5mm, 3.0mm), and Nozzle Cleaning Tool.
* **Flash Drive:** 12mm x 4.5mm slot designed to catch the plastic housing while the metal plug drops through.
* **Accessory Hook:** 8mm wide hook for 11mm+ diameter items (like calipers or nozzle brushes).---

*Note: This is an aftermarket modification. Use the included M3 washers on the nut side to distribute pressure and prevent cracking the enclosure panels.*