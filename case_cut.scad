include <case.scad>;

translate([interior.x, 0, 0])
  rotate([180, 0, 180])
    bottom(bottom_size);

translate([0, bottom_size.y + 10]) {
  front_panel();

  translate([0, interior.z + 10]) {
    translate([interior.x, 0, 0])
      rotate([180, 0, 180])
        rear_panel();

    translate([0, interior.y + 10]) {
      side();
      translate([interior.z *2, interior.y, 0])
      rotate([0, 0, 180])
      side();

      translate([0, interior.y + 20]) {
      }
    }
  }
}
