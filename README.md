# Transmission Line Parameter Calculator

A MATLAB tool that computes the per-kilometre inductance and capacitance of a
transposed three-phase transmission line for **arbitrary conductor bundle
geometry**.

---

## What it does

The series inductance and shunt capacitance of a three-phase line depend
entirely on geometry: how far apart the phases sit, and how the individual
sub-conductors within each bundle are arranged. Given that geometry, this script
returns the line parameters per kilometre.

---

## Method

**Transposition.** On a transposed line each phase occupies every physical
position over the length of the line, so the asymmetry averages out and the
three phases can be described by a single equivalent spacing - the geometric
mean distance:

```
GMD = (D_ab . D_bc . D_ca)^(1/3)
```

**Bundling.** A bundle of several sub-conductors behaves like one conductor with
a larger effective radius. The bundle-equivalent geometric mean radius collapses
the sub-conductor positions into that single value:

```
GMR_bundle = ( GMR_conductor . PRODUCT d_ij )^(1/n)
```

Handling arbitrary geometry means computing this from the actual sub-conductor
coordinates rather than relying on the standard two-, three- and four-conductor
formulas.

**Parameters.**

```
L = 2e-7 . ln(GMD / GMR_L)     H/m
C = 2.pi.eps0 / ln(GMD / GMR_C)    F/m
```

Note that the inductance uses the GMR including the internal flux linkage
factor, while the capacitance uses the physical radius - a distinction that is
easy to lose when the calculation is done by hand.

---

## Usage

Open the script in MATLAB, set the phase positions and bundle configuration at
the top, and run it. The computed parameters are printed to the console.

---

## Repository contents

```
transmission_line.m    Main script
docs/                  Calculated parameter results
```

---

## Context

Coursework project for **Power System Analysis I**, Shahid Beheshti University,
Autumn 2025.
