use <zrail.scad>;


// Eurorack standards:
face_height = 128.5;
space_between_rails = 122.5;

z_rail_length = 426.4;
zrail_lip = 5;
zrail_inset_from_face = 15;

power_supply = [129, 98, 38];


enclosure_depth = 120;

// how much the bottom gets pulled in. This creates the angle.
side_bottom_inset = 25;

m3_hole_size = 3.3;
m3_nut = [2.5, 5.5];

material_width = 3;

tnut_inset_from_edge = 20;

front_spacing = face_height + zrail_lip * 2;

back_size = [z_rail_length, front_spacing];
side_size = [enclosure_depth, front_spacing];

power_supply_pos = [(back_size.x - power_supply.x)/2, 10];

angle = atan(side_bottom_inset/face_height);


*back(back_size);
mockup();
*side();

$fa = 0.5;
$fs = 0.5;
smidge = 0.01;


module mockup() {
  rotate([angle, 0, 0]) {
    rotate([-angle, 0, 0]) {
      linear_extrude(height=material_width)
        back(back_size);
      color("#aaa")
        translate([0, 0, -10])
        translate(power_supply_pos)
          cube(power_supply);

    }

    color("green")
    translate([0, zrail_lip, enclosure_depth - side_bottom_inset])
      module_faceplate();

    color("#ccc")
      translate([0, zrail_lip + material_width, 0]) {
        translate([0, space_between_rails, enclosure_depth - side_bottom_inset - zrail_inset_from_face])
          rotate([90, 90, 90])
            zrail(back_size.x);

      translate([0, 0, enclosure_depth - side_bottom_inset - zrail_inset_from_face])
        mirror([0, 1, 0])
          rotate([90, 90, 90])
            zrail(back_size.x);
      }

    cube([back_size.x, material_width, enclosure_depth - side_bottom_inset]);
    translate([0, back_size.y - material_width, -side_bottom_inset])
      cube([back_size.x, material_width, enclosure_depth]);

    // sides
    translate([0, 0, side_size.x - side_bottom_inset]) {
      translate([back_size.x, 0, 0])
        rotate([0, 90, 0])
          linear_extrude(height=material_width)
            side(side_size, side_bottom_inset);
      translate([-material_width, 0, 0])
        rotate([0, 90, 0])
          linear_extrude(height=material_width)
            side(side_size, side_bottom_inset);
      }
  }
}

module m3_tnut(length) {
  tnut([length, m3_hole_size], m3_nut);
}

module tnut(size, nut, extra=1) {
  translate([0, -size.y/2]) {
    square(size);
    translate([size.x - extra - nut.x, -(nut.y - size.y) / 2])
      square(nut);
  }
}

module back(size) {
  difference() {
    square(size);
    tnut_screw_length = 10;
    tnut_hole = tnut_screw_length - material_width;

    translate([-smidge, tnut_inset_from_edge])
      m3_tnut(tnut_hole + smidge);
    translate([-smidge, size.y - tnut_inset_from_edge])
      m3_tnut(tnut_hole + smidge);
    translate([size.x + smidge, tnut_inset_from_edge])
      rotate([0, 0, 180])
        m3_tnut(tnut_hole + smidge);
    translate([size.x + smidge, size.y - tnut_inset_from_edge])
      rotate([0, 0, 180])
        m3_tnut(tnut_hole + smidge);

    translate(power_supply_pos + [power_supply.x + 10, 0])
      power_plug_holes();

    translate(power_supply_pos)
      square([power_supply.x, power_supply.y]);
  }
}

module power_plug_holes() {
  plug_hole = [28, 20];
  screw_offset = 6;
  switch_offset = 8;

  translate([screw_offset + 3, 0]) {
    rounded_square(plug_hole, 4);
    translate([-screw_offset, plug_hole.y/2])
      circle(r=1.7);
    translate([plug_hole.x + screw_offset, plug_hole.y/2])
      circle(r=1.7);

    switch_hole = [12.9, 19.8];

    translate([plug_hole.x + screw_offset + switch_offset, 0])
      square(switch_hole);
  }
}

module side(size, back_slope) {
  minkowski() {
    polygon([[0, 0], [size.x - back_slope, 0], [size.x, size.y], [0, size.y]]);
    circle(r=5);
  }
}

module module_faceplate() {
  cube([40.3, face_height, 2]);
}

module rounded_square(size, radius) {
  translate([radius, radius])
    minkowski() {
      circle(r=radius);
      square(size - [radius*2, radius*2]);
    }
}
