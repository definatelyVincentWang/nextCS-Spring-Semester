class RegularGon extends PathShape {
  int nsides;
  int radius;
  
  public RegularGon(int bx, int by, int bw, int bh, int nsides, int radius) {
    super(bx,by,bw,bh);
    centroid[0] = bx + bw / 2 + width / 2;
    centroid[1] = by + bh / 2 + height / 2;
    this.nsides = nsides;
    this.radius = radius;
    generateRegularPolygon();
  }
  
  void generateRegularPolygon() {
    float innerAngle = radians(360.0 / nsides);
    int cx = centroid[0];
    int cy = centroid[1];
    for (int i = 0; i < nsides; i++) {
      xs.append(int(radius * cos(innerAngle * i) + cx));
      ys.append(int(radius * sin(innerAngle * i) + cy));
    }
  }
}
