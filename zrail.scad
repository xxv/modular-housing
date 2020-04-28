module zrail(length) {
  translate([-14.285, -5.045])
  linear_extrude(height=length)
    import("z-rails.dxf"); 
}
