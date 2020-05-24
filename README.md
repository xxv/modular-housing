A Modular Synthesizer Housing
=============================

A simple modular case/housing that can be built with somewhat standard parts
and lasercut panels.

This is intended to house a Mean Well RT-65B power supply.

Case Ingredients
----------------

* [TipTop Audio Z-rails
  84hp](https://www.sweetwater.com/store/detail/ZRails84HPsv--tiptop-audio-z-rails-84hp-silver)
* 2× M4 bolts (for the Z-rails)
* 4× M3 nuts (standard)
* 4× M3×10 bolts (pref. socket cap)
* 3mm lasercuttable material (I used Glowforge Medium Maple Plywood)

Power Supply Ingredients
------------------------
* 1x Mean Well RT-65B power supply (Digi-Key part [1866-4311-ND](https://www.digikey.com/product-detail/en/mean-well-usa-inc/RT-65B/1866-4311-ND/7706375))
* 1x IEC 320-C14 panel mount power inlet (Digi-Key part [Q336-ND](https://www.digikey.com/product-detail/en/qualtek/703W-00-08/Q336-ND/1164207))
* 1x power switch (Digi-Key part [CH755-ND](https://www.digikey.com/product-detail/en/zf-electronics/SRB22A2FBBNN/CH755-ND/446021))
* 14 gauge solid copper wire (I grabbed some from a cut of standard 15A home wiring Romex)
* 5× 14-16 gauge crimp spade connectors (shielded!) for crimping to the power inlet and switch
* 2× M2.5×10 flat head bolts (black, for mounting the power inlet)
* 2× M2.5 nuts
* 2× M2.5 washers
* 2× M3x6 bolts (for mounting the power supply to the housing)

Case Steps
----------

1. Cut out the parts
   1. load up `case_cut.scad` in OpenSCAD, render it, save it to SVG.
   2. Open up in Inkscape and add your own decorative etching.
   3. Cut those bad boi out!
2. Load up `case_mockup.scad` to see how all the parts fit together.
   The little "t" tnut cutouts in the bottom panel are for trapping a nut.
3. Wire up the power supply first, then fully assemble the case.

Power Supply Steps
------------------

1. Attach power supply to the bottom panel with M3 screws.
2. Attach power inlet with M2.5x10 bolts, washers, & nuts.
3. Clip in switch.
4. Wire Neutral (N) and Earth (E) directly from inlet to power supply (note the markings on the
   connector and on the screw terminals)
5. Wire Load (L) from inlet to switch, then from switch to power supply.
5. Once your wires are laid out, crimp on connectors. Crimp them hard! Crimping to solid core wire
   requires extra effort. Make sure they don't wiggle.
6. Double, then triple-check all your wiring for this. Make sure that none of the metal for the
   mains voltage are exposed to the inside of the case (with the exception of the earth/ground
   wire). This means covering up the screw terminals with electrical tape or similar. Remember:
   while 120VAC wiring can be extremely dangerous, if you're careful and treat it with respect, you
   can build with it safely.
