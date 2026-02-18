# 📸 SnapFit Hero Image Guide

Follow these steps to generate high-resolution, consistent "Hero" images for the SnapFit collection.

## 1. OpenSCAD Environment Setup

- **Background**: Go to `Edit > Preferences > 3D View`. Set **Color Scheme** to **Production** (White) or **Tomorrow Night** (Black).
- **Cleanup**: Hide the UI clutter. Press `Ctrl + 2` (Hide Axes) and `Ctrl + 3` (Hide Grid).

## 2. Framing & Aspect Ratio

Standardizing the aspect ratio prevents your logos from being cropped strangely in gallery views.

1. **Set Aspect Ratio**: In the panel at the bottom of the OpenSCAD window, set the **Width** to `800` and **Height** to `800`.
2. **Orthographic View**: Press `Ctrl + P` to turn off perspective distortion for a flat "graphic" look.
3. **Top View**: Press `Ctrl + 4` to look directly down at the logo.
4. **Center & Zoom**: Press `Ctrl + Shift + V` to center, then `Ctrl + 0` to zoom to fit.

## 3. High-Resolution Export

1. Go to `File > Export > Export as Image...`.
2. Save the file into the project's `/images/` subfolder.
3. **Naming Convention**: `snapfit-{team}-hero.png`.
4. **Reset UI**: After saving, return the aspect ratio in the bottom panel to your standard working size (e.g., `1920` x `678`).

## 4. Visual Quality (Z-Fighting Fix)

If the colors look "speckled" in the preview, it is because the inserts are sitting at the exact same height as the base. In your `.scad` file, ensure your preview code offsets the inserts slightly:

```openscad
// Optimized Preview Code for Screenshots
color("white") white_base();
color("red") translate([0,0,base_thickness - pocket_depth + 0.2]) red_insert();
color("blue") translate([0,0,base_thickness - pocket_depth + 0.2]) blue_inserts();

```
