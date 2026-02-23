# The Slasher Sphere Collection: Horror-Themed Pokéballs

High-precision, multi-part 3D prints merging the world of Pokémon with iconic horror film slashers. Designed for seamless assembly and a premium, prop-quality feel.

This collection utilizes parametric OpenSCAD engineering to transform 2D horror motifs into 3D spherical objects. By utilizing a hybrid system of friction-fit internal hardware and glue-in external details, these spheres are optimized for clean, multi-color results without the need for a multi-material system (like an AMS or MMU).

## 🧬 The "Slasher" DNA (Universal Specs)

To ensure consistency across the entire collection, every sphere in this project adheres to these baseline engineering rules:

- **The Fit:** Structural internal parts (filler pegs) use a `0.20mm` mechanical clearance.
- **The Shells:** Standardized `80mm` diameter (40mm radius) for a consistent collection display.
- **The Walls:** Requires **3 to 4 wall perimeters** to ensure the recessed feature pockets have a solid plastic backing.
- **The Layers:** Optimized for `0.2mm` layer height for a balance of speed and surface finish.
- **The Squish:** *Elephant Foot Compensation* is mandatory (set to `0.15mm`). Because the masks and detail "chips" sit flush against the shell, any first-layer flare will prevent them from seating properly.

## 🛠 Collection-Wide Assembly Tips

- **Internal Alignment:** Every sphere uses a standardized **Rectangular Filler Peg**. This provides massive surface area for gluing and ensures the top and bottom hemispheres never twist or shift.
- **Support-Free Design:** All spheres are designed to be printed with the equatorial flat faces down on the build plate. This allows the organic curves of the ball to print flawlessly without slicer-generated supports.
- **The "Flush" Finish:** The detail chips (eyes, chevrons, etc.) are dimensioned to sit `0.03mm` proud of the shell surface in the model to ensure they look sharp and deliberate once glued in.
- **Material Choice:** PLA is recommended for the shells for crisp details; however, PETG can be used for the internal filler peg if you require higher impact resistance.

## 🧪 Calibration & Testing
Before committing to a full sphere, verify your printer's tolerances using the **Slasher Fit Test** (located in the `/tools/` folder).

1. **Print the Test Block:** A small section of a sphere shell with a single chip pocket.
2. **Print the Test Chip:** A standard circular insert.
3. **Verify:** If the chip is too loose, decrease `chip_clearance` in the `.scad` file. If it won't go in even after removing first-layer squish, increase it.

---

## 🔪 Slasher Roadmap & Status

**Key:** ✅ = Designed & Uploaded | ⏳ = In Progress | 📅 = Planned

### The Icons of Terror

**Friday the 13th**
- [x] ✅ **[Jason Voorhees](./jason/)**

**A Nightmare on Elm Street**
- [ ] 📅 Freddy Krueger

**Halloween**
- [ ] 📅 Michael Myers

**Texas Chainsaw Massacre**
- [ ] 📅 Leatherface

### Modern Menaces

**Scream**
- [ ] ⏳ Ghostface

**Child's Play**
- [ ] 📅 Chucky

**Saw**
- [ ] 📅 Billy the Puppet

**IT**
- [ ] 📅 Pennywise

---

### Legal Disclaimer

*All designs in this directory are provided as **fan art** for personal, non-commercial use only. These designs are not affiliated with, authorized by, or endorsed by the Friday the 13th franchise, New Line Cinema, Warner Bros, or any other respective film studios or owners. All slasher icons, logos, and trademarks are the property of their respective owners.*

**For full legal information, safety warnings, and licensing restrictions, please see our root [LEGAL.md](../../../LEGAL.md).**