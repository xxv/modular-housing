A Modular Synthesizer Housing
=============================

A simple modular case/housing that can be built with somewhat standard parts
and lasercut panels.

This has a cutout on the back for a Mean Well RT-65B power supply.

Case Ingredients
----------------

* 4x 30cm [OpenBeam][] rods
* 8x M3x10 bolts
* M3 screw tap
* 3mm lasercuttable material (I used Glowforge Medium Maple Plywood)
* A bunch of standard M3 nuts

Power Supply Ingredients
------------------------
* 1x Mean Well RT-65B power supply (Digi-Key part [1866-4311-ND](https://www.digikey.com/product-detail/en/mean-well-usa-inc/RT-65B/1866-4311-ND/7706375))
* 1x IEC 320-C14 panel mount power inlet (Digi-Key part [Q336-ND](https://www.digikey.com/product-detail/en/qualtek/703W-00-08/Q336-ND/1164207))
* 1x power switch (Digi-Key part [CH755-ND](https://www.digikey.com/product-detail/en/zf-electronics/SRB22A2FBBNN/CH755-ND/446021))
* 14 gauge wire
* 5x 14-16 gauge crimp spade connectors
* 2x M3x10 flat head bolts
* 2x M3x6 bolts
* 4x M3 nuts
* 2x M3 washers

Case Steps
----------

1. Cut out the parts
    1. 2x of the side.svg with the OpenBeam holes turned on, center holes off
    2. 2x of the side.svg with the OpenBeam holes turned off, center holes on
    3. 1x back.svg
    4. 2x top_bottom.svg
2. Tap the end holes of the OpenBeam rods with the M3 tap
3. Place the rods through OpenBeam holes in one of the sides, with the thinner side facing forward
4. Fill the front-most part with a bunch of M3 nuts so you can screw your modules on
5. Place rods through the other OpenBeam side panel
6. Screw the side end caps on

Power Supply Steps
------------------

1. Attach power supply with M3x6 screws + nuts to the OpenBeam rod (I chose to hang it from the back)
2. Attach power inlet with M3x10 bolts, washers, & nuts
3. Attach crimp spade connectors to wire
4. Wire Neutral (N) and Earth (E) directly from inlet to power supply
5. Wire Load (L) from inlet to switch, then from switch to power supply

[openbeam]: https://ztautomations.com/openbeam/
