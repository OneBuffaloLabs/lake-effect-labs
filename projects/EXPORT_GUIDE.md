# STL Export Guide

This guide explains how to export individual parts from OpenSCAD to STL files for 3D printing.

---

## 1. Select the Part

OpenSCAD only exports geometry that is currently active in the script. Navigate to the **RENDER SELECTION** section at the bottom of the `.scad` file.

1. Comment out the **PREVIEW COLOR VIEW** lines.
2. Un-comment only the specific part you intend to export.

**Example for exporting the base:**

```openscad
white_base();
// red_insert();
// blue_inserts();

```

---

## 2. Render and Export

You must perform a full render before an STL can be generated.

1. **Render (F6):** Press `F6` to calculate the final mesh. Wait for the process to complete in the console.
2. **Export STL:** Go to `File > Export > Export as STL (binary)...` or click the STL button in the toolbar.
3. **Repeat:** Comment out the finished part, un-comment the next part, and repeat the process.

---

## 3. Naming Convention

Use a consistent naming format to keep files organized for slicing and repository management:

`snapfit-{team}-{part}-{color}.stl`

**Examples:**

* `snapfit-bills-base-white.stl`
* `snapfit-bills-insert-red.stl`

---

## 4. Verification

Before printing, verify the following in the OpenSCAD console and your slicer:

* **Manifold Status:** Ensure the console reads `VBO is manifold`. This confirms the model is watertight.
* **Dimensions:** Import the STL into your slicer and verify the width matches the `target_width` defined in the script.
* **Tolerances:** Ensure your slicer's **Elephant Foot Compensation** is set to at least `0.15mm` to maintain the designed fit.