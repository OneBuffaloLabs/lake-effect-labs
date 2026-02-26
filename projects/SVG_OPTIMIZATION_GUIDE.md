# SVG Optimization Guide for OpenSCAD Parametric Modeling

When using `import()` in OpenSCAD, the software treats the SVG's **Page Origin (0,0)** as the anchor point. If your drawing is not centered on that origin, the object will "orbit" around the center of your 3D model rather than sitting on the surface.

Follow these steps to ensure your SVGs are "Plug-and-Play."

---

## 🛠 Required Software

- **Inkscape** (Free, Open Source) — Recommended for its "Plain SVG" export.

---

## 1. Zeroing the Geometry (The "Must-Do")

OpenSCAD needs the center of your object to be at `[0,0]`.

1.  **Open the SVG** in Inkscape.
2.  **Select the Object** (the eye, mouth, or logo).
3.  **Ungroup Everything**: Press `Ctrl + Shift + G` repeatedly until there are no more groups.
4.  **Convert to Path**: Go to `Path > Object to Path`. This ensures OpenSCAD can read the geometry.
5.  **Center the Object**:
    - Open the **Align and Distribute** panel (`Ctrl + Shift + A`).
    - Set "Relative to:" to **Page**.
    - Click **Center on vertical axis** and **Center on horizontal axis**.
6.  **Verify Coordinates**: Look at the **X** and **Y** boxes in the top toolbar. They should show `0` or a very small number.

---

## 2. Document Cleanup

OpenSCAD looks at the "Document Properties" to determine scale and placement.

1.  **Resize Page**: Go to `File > Document Properties` (`Ctrl + Shift + D`).
2.  Click **Resize page to drawing or selection**. This makes the "paper" the exact same size as your part.
3.  **Check Display Units**: Set "Display units" to **mm**.
4.  **Check Scale**: Ensure the scale is set to **1.0**. If Inkscape shows a scale like `0.26458`, it will import into OpenSCAD at the wrong size.

---

## 3. The "Plain SVG" Export

Inkscape adds a lot of "metadata" (extra code) that can confuse OpenSCAD.

1.  Go to `File > Save As...`.
2.  Change the file type from "Inkscape SVG" to **Plain SVG**.
3.  This removes layers, editor metadata, and specialized transforms, leaving only the raw path data.

---

## 4. OpenSCAD Implementation Template

Once optimized, you no longer need complex `translate()` math in your `.scad` file. Use this clean template:

```openscad
// Simple, clean loader
module load_feature(filename, clearance = 0) {
    offset(delta = clearance)
        import(filename);
}

// Example usage on a sphere
module place_on_ball(tilt, pan) {
    rotate([0, 0, pan])
        rotate([-tilt, 0, 0])
            translate([0, -40, 0]) // 40 = ball_radius
                rotate([-90, 0, 0])
                    linear_extrude(height = 5)
                        load_feature("eye.svg", -0.05);
}
```
