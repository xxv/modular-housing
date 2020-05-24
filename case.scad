use <zrail.scad>;


// Eurorack standards:
face_height = 128.5;
space_between_rails = 122.5;

z_rail_length = 426.4;
zrail_lip = 5;
zrail_inset_from_face = 14.2;

power_supply = [129, 98, 38];
power_supply_hole_spacing = 33;
power_supply_hole_size = 3.3;


enclosure_depth = 120;

// how much the bottom gets pulled in. This creates the angle.
side_bottom_inset = 25;
side_radius = 5;

m3_hole_size = 3.3;
m3_nut = [2.5, 5.5];

m4_hole_size = 4.4;

material_width = 3;

tnut_inset_from_edge = 20;
tnut_screw_length = 10;

front_spacing = face_height + zrail_lip * 2;

interior = [z_rail_length, front_spacing, enclosure_depth];

bottom_size = [interior.x, interior.y - material_width * 2 - 10];
side_size = [interior.z, interior.y];

tab_width = 10;
tab_inset_from_edge = 10;
bottom_tab_inset_from_edge = (tnut_inset_from_edge - tab_width)/2;

power_supply_pos = [80, 30];

angle = atan(side_bottom_inset/interior.y);


$fa = 0.5;
$fs = 0.5;
smidge = 0.01;


module mockup() {
  rotate([angle, 0, 0]) {
    rotate([-angle, 0, 0]) {
      translate([0, (interior.y - bottom_size.y) / 2])
      linear_extrude(height=material_width)
        bottom(bottom_size);
      color("#aaa")
        translate([0, 0, material_width])
        translate(power_supply_pos)
          cube(power_supply);
    }

    %color("green") {
      translate([0, zrail_lip, enclosure_depth - side_bottom_inset - 2 + side_radius]) {
        module_faceplate();
        translate([0.5, 11, -60])
        cube([39.3, 106.5, 60]);
        }
    }

    color("#ccc")
      translate([0, zrail_lip + material_width, 0]) {
        translate([0, 0, enclosure_depth - side_bottom_inset - zrail_inset_from_face + side_radius]) {
        translate([0, space_between_rails, 0])
          rotate([90, 90, 90])
            zrail(interior.x);

        mirror([0, 1, 0])
          rotate([90, 90, 90])
            zrail(interior.x);
        }
      }

    translate([0, material_width, 0])
      rotate([90, 0, 0])
        linear_extrude(height=material_width)
          front_panel();

    translate([0, interior.y, -side_bottom_inset])
      rotate([90, 0, 0])
        linear_extrude(height=material_width)
          rear_panel();

    // sides
    color("red")
    translate([0, 0, side_size.x - side_bottom_inset]) {
      translate([interior.x, 0, 0])
        rotate([0, 90, 0])
          linear_extrude(height=material_width)
            side();
      translate([-material_width, 0, 0])
        rotate([0, 90, 0])
          linear_extrude(height=material_width)
            side();
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

module panel(size, tab_inset) {
  square(size);

  tab_depth = material_width;

  translate([-tab_depth + smidge, tab_inset])
    square([tab_depth + smidge, tab_width]);

  translate([-tab_depth + smidge, size.y - tab_inset - tab_width])
    square([tab_depth + smidge, tab_width]);

  translate([size.x - smidge, tab_inset])
    square([tab_depth + smidge, tab_width]);

  translate([size.x - smidge, size.y - tab_inset - tab_width])
    square([tab_depth + smidge, tab_width]);
}

module bottom(size) {
  difference() {
    panel(size, bottom_tab_inset_from_edge);
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


    translate(power_supply_pos + [73.5 + 4.5, 31]) {
      circle(d=power_supply_hole_size);
      translate([0, power_supply_hole_spacing])
        circle(d=power_supply_hole_size);
    }
  }
}

module front_panel() {
  panel([interior.x, enclosure_depth - side_bottom_inset + side_radius], tab_inset_from_edge);
}

module rear_panel() {
  size = [interior.x, enclosure_depth + side_radius];
  difference() {
    panel(size, tab_inset_from_edge);

    translate(power_supply_pos + [power_supply.x - 130, -20])
      rotate([0, 180])
      power_plug_holes();
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

    switch_hole = [12.5, 19.8];

    translate([plug_hole.x + screw_offset + switch_offset, 0])
      square(switch_hole);
  }
}

module side() {
  size = side_size;

  difference() {
    minkowski() {
      polygon([[0, 0], [size.x - side_bottom_inset, 0], [size.x, size.y], [0, size.y]]);
      circle(r=side_radius);
    }

    // zrail holes
    translate([zrail_inset_from_face - side_radius, zrail_lip + material_width])
      circle(d=m4_hole_size);
    translate([zrail_inset_from_face - side_radius, size.y - zrail_lip - material_width])
      circle(d=m4_hole_size);

    // tab slots
    translate([tab_inset_from_edge - side_radius, 0])
      square([tab_width, material_width]);

    translate([tab_inset_from_edge - side_radius, size.y - material_width])
      square([tab_width, material_width]);

    translate([size.x - tab_inset_from_edge - side_bottom_inset - tab_width, 0])
      square([tab_width, material_width]);

    translate([size.x - tab_inset_from_edge - tab_width,  size.y - material_width])
      square([tab_width, material_width]);

    bottom_size_difference = interior.y - bottom_size.y;
    tnut_inset = tnut_inset_from_edge + bottom_size_difference/2;

    // bottom connectors
    translate([size.x - side_bottom_inset, 0])
      rotate([0, 0, -angle]) {
        translate([-material_width/2, size.y - tnut_inset])
          circle(d=m3_hole_size);
        translate([-material_width/2, tnut_inset])
          circle(d=m3_hole_size);
        translate([-material_width, bottom_tab_inset_from_edge + bottom_size_difference/2])
          square([material_width, tab_width]);
        translate([-material_width, size.y - tab_width - (bottom_tab_inset_from_edge + bottom_size_difference/2)])
          square([material_width, tab_width]);
      }
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
